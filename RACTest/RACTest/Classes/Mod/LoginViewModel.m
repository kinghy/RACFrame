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

#define kFilterNumber @"1234567890"
#define kFilterLetter @"abcdefghijklmnopqrstuvwxyz"

@implementation LoginViewModel

#pragma mark - init methods

#pragma mark - extends methods

-(void)viewModelDidLoad{
    @weakify(self);
    _loginCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self doLogin:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - public methods

/**  格式化手机号 */
- (NSString *)formatMobile:(NSString *)string{
    NSString *str = [self filterMobile:string];
    if(str.length>7){
        str = [NSString stringWithFormat:@"%@ %@ %@",[str substringToIndex:3],[str substringWithRange:NSMakeRange(3, 4)],[str substringWithRange:NSMakeRange(7, str.length-7)]];
    }else if(str.length>3){
        str = [NSString stringWithFormat:@"%@ %@",[str substringToIndex:3],[str substringWithRange:NSMakeRange(3, str.length-3)]];
    }
    return str;
}

-(NSString *)formatPassword:(NSString *)string{
    return [self filterPassword:string];
}

-(NSString *)formatVerifyCode:(NSString *)string{
    return [self filterVerifyCode:string];
}

-(BOOL)validateMobile:(NSString *)string{
    return (string.length==11) && [[self filterMobile:string] isEqualToString:string];
}

-(BOOL)validatePassword:(NSString *)string{
    return string.length>=6 && string.length<=18 && [[self filterPassword:string] isEqualToString:string];
}

-(BOOL)validateVerifyCode:(NSString *)string{
    return string.length == 4 && [[self filterVerifyCode:string] isEqualToString:string];
}

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
    if(![self validateMobile:self.phoneNum]){
        errorMsg = @"请输入有效的11位手机号码";
    }else if(![self validatePassword:self.password]){
        errorMsg = @"请输入6-18位数字、字母，字母区分大小写";
    }else if(self.verfyImage && ![self validateVerifyCode:self.verifyCode]){
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
    
    PreReadMassMsgParam *preParam = [PreReadMassMsgParam new];
    preParam.user_type = @"1";
    RACSignal *preSignal = [RFNetAdapter netAdapterWithParam:preParam].signal;

    UserInfoParam *userParam = [UserInfoParam new];
    RAC(userParam,uid) = RACObserve(self, uid);
    RACSignal *userSignal = [RFNetAdapter netAdapterWithParam:userParam].signal;
    
    return [RACSignal concat:@[loginSignal,preSignal,userSignal]];//先后执行
}

-(void)handleWithLoginSingal:(RACSignal*)signal andSubscriber:(id<RACSubscriber>)subscriber{
    @weakify(self)
    [signal subscribeNext:^(id x) {
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

-(NSString*)filterMobile:(NSString*)string{
    //去除所有不是数字的字符
    NSCharacterSet *setToRemove =[[NSCharacterSet characterSetWithCharactersInString:kFilterNumber] invertedSet ];
    NSString *str =[[string componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    //必须以1开头
    if(![str hasPrefix:@"1"]){
        return @"";
    }
    
    //大于11就裁剪到11;
    if(str.length>11){
        str = [str substringToIndex:11];
    }
    return str;
}


-(NSString*)filterPassword:(NSString*)string{
    //去除所有不是数字和字母的字符
    NSString* filter = [NSString stringWithFormat:@"%@%@%@",kFilterNumber,[kFilterLetter lowercaseString],[kFilterLetter uppercaseString]];
    NSCharacterSet *setToRemove =[[NSCharacterSet characterSetWithCharactersInString:filter] invertedSet ];
    NSString *str =[[string componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    
    //大于18就裁剪到18;
    if(str.length>18){
        str = [str substringToIndex:18];
    }
    return str;
}

-(NSString*)filterVerifyCode:(NSString*)string{
    //去除所有不是数字和字母的字符
    NSString* filter = [NSString stringWithFormat:@"%@%@%@",kFilterNumber,[kFilterLetter lowercaseString],[kFilterLetter uppercaseString]];
    NSCharacterSet *setToRemove =[[NSCharacterSet characterSetWithCharactersInString:filter] invertedSet ];
    NSString *str =[[string componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    
    //大于18就裁剪到18;
    if(str.length>4){
        str = [str substringToIndex:4];
    }
    return str;
}

#pragma mark - Action methods
@end
