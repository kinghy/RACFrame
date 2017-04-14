//
//  LoginViewModel.m
//  RACTest
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginParam.h"
#import "LoginEntity.h"
#import "SecuritycodePicParam.h"
#import "VerifySecurityCodeParam.h"
#import "PreReadMassMsgParam.h"
#import "UserInfoParam.h"
#import "UserInfoEntity.h"
#import "UserViewModel.h"



@implementation LoginViewModel

#pragma mark - init methods

#pragma mark - extends methods

-(void)viewModelDidLoad{
    [super viewModelDidLoad];
    @weakify(self);
    _loginCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self doLogin:subscriber];
            return nil;
        }];
    }];
    self.user = [UserViewModel sharedInstance];
}

#pragma mark - public methods

-(void)refreshVerifyPic{
    SecuritycodePicParam* param = [SecuritycodePicParam new];
    param.width = @"101";
    param.height = @"50";
    param.fontSize = @"16";
    param.UUID = [OpenUDID value];
    @weakify(self)
    [[RFNetAdapter netAdapterWithParam:param].signal subscribeNext:^(id x) {
        @strongify(self)
        self.verfyImage = x;
    }];
}

#pragma mark - private methods
-(void)doLogin:(id<RACSubscriber>)subscriber{
    NSString *errorMsg = nil;
    if(![self.phoneNum validateMobile]){
        errorMsg = @"请输入有效的11位手机号码";
    }else if(![self.password validatePassword]){
        errorMsg = @"请输入6-18位数字、字母，字母区分大小写";
    }else if(self.verfyImage && ![self.verifyCode validateVerifyCode]){
        errorMsg = @"请输入4位验证码";
    }
    
    if(errorMsg){
        NSError *error = [NSError errorWithDomain:@"LoginViewModel" code:1000 userInfo:@{kErrorMsg:errorMsg}];
        [subscriber sendError:error];
    }else if(self.verfyImage){
        VerifySecurityCodeParam *param = [VerifySecurityCodeParam new];
        param.code = self.verifyCode;
        param.UUID = [OpenUDID value];
        @weakify(self)
        [self handleWithLoginSingal:[[RFNetAdapter netAdapterWithParam:param].signal then:^RACSignal *{
            @strongify(self)
            return [self loginSignal];
        }] andSubscriber:subscriber];
    }else{
        [self handleWithLoginSingal:[self loginSignal] andSubscriber:subscriber];
    }
}

-(RACSignal*)loginSignal{
    LoginParam *param = [LoginParam new];
    param.logInID = self.phoneNum;
    param.password = self.password;
    param.logInType = @"2";
    RACSignal *loginSignal = [RFNetAdapter netAdapterWithParam:param].signal;
    
    RACSignal *preSignal = [[RACSignal return:nil] flattenMap:^RACStream *(id value) {
        PreReadMassMsgParam *preParam = [PreReadMassMsgParam new];
        preParam.user_type = @"1";
        return [RFNetAdapter netAdapterWithParam:preParam].signal;
    }];

    @weakify(self)
    RACSignal *userSignal = [[RACSignal return:nil] flattenMap:^RACStream *(id value) {
        @strongify(self);
        UserInfoParam *userParam = [UserInfoParam new];
        userParam.uid = self.user.uid;
        return [RFNetAdapter netAdapterWithParam:userParam].signal;
    }];
    
    return [RACSignal concat:@[loginSignal,preSignal,userSignal]];//先后执行
}

-(void)handleWithLoginSingal:(RACSignal*)signal andSubscriber:(id<RACSubscriber>)subscriber{
    @weakify(self)
    [signal subscribeNext:^(id x) {
        @strongify(self);
        if([x isKindOfClass:[LoginEntity class]]){
            LoginEntity* l = (LoginEntity*)x;
            [self.user update];
            self.user.phone_num = self.phoneNum;
            self.user.uid = l.uid;
            self.user.session_id = l.session_id;
            [self.user save];
        }else if([x isKindOfClass:[UserInfoEntity class]]){
            UserInfoEntity* u = (UserInfoEntity*)x;
            [self.user update];
            self.user.uid = u.uid;
            self.user.nick_name = u.nick_name;
            self.user.user_type = u.user_type;
            self.user.bind_mobile = u.bind_mobile;
            self.user.bind_mail = u.bind_mail;
            self.user.bind_weixin = u.bind_weixin;
            self.user.pic = u.pic;    //头像地址
            self.user.bind_prod = u.bind_prod;
            self.user.bind_prod_tblid = u.bind_prod_tblid;
            self.user.prod_username = u.prod_username;
            self.user.bind_cpb = u.bind_cpb;
            self.user.bind_cpb_tblid = u.bind_cpb_tblid;
            self.user.create_time = u.create_time;
            self.user.nicknm_status = u.nicknm_status;//昵称状态，2为审核拒绝
            [self.user save];
        }
        [subscriber sendNext:x];
    } error:^(NSError *error) {
        @strongify(self)
        NSString *code = [NSString stringWithFormat:@"%@",error.userInfo[kErrorCode]];
        if([code isEqualToString:@"79002"] || self.verfyImage){//失败次数过多
            [self refreshVerifyPic];
        }
        [subscriber sendError:error];
    } completed:^{
        [subscriber sendCompleted];
    }];
}


#pragma mark - delegate methods



#pragma mark - Action methods
@end
