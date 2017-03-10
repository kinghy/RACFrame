//
//  UserViewModel.m
//  RACTest
//
//  Created by  rjt on 17/2/28.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UserViewModel.h"
#import "UserPersistance.h"

@interface UserViewModel()
@property (nonatomic,strong) UserPersistance *user;
@end

@implementation UserViewModel
#pragma mark - init methods
+(instancetype)sharedInstance{
    static UserViewModel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
#pragma mark - extends methods
-(void)viewModelDidLoad{
    _user = (UserPersistance*)[[RFDefaultsPersistManager sharedInstace] persistanceByClass:[UserPersistance class] andTag:kUserPersistanceKey];
    [self update];
}
#pragma mark - public methods
-(void)update{
    [_user refresh];
    self.uid = _user.uid;
    self.nick_name = _user.nick_name;
    self.user_type = _user.user_type;
    self.bind_mobile = _user.bind_mobile;
    self.bind_mail = _user.bind_mail;
    self.bind_weixin = _user.bind_weixin;
    self.pic = _user.pic;
    self.bind_prod = _user.bind_prod;
    self.bind_prod_tblid = _user.bind_prod_tblid;
    self.prod_username = _user.prod_username;
    self.bind_cpb = _user.bind_cpb;
    self.bind_cpb_tblid = _user.bind_cpb_tblid;
    self.create_time = _user.create_time;
    self.nicknm_status = _user.nicknm_status;
    self.session_id = _user.session_id;
    self.phone_num = _user.phone_num;
    
}

-(void)save{
    _user.uid = self.uid;
    _user.nick_name = self.nick_name;
    _user.user_type = self.user_type;
    _user.bind_mobile = self.bind_mobile;
    _user.bind_mail = self.bind_mail;
    _user.bind_weixin = self.bind_weixin;
    _user.pic = self.pic;
    _user.bind_prod = self.bind_prod;
    _user.bind_prod_tblid = self.bind_prod_tblid;
    _user.prod_username = self.prod_username;
    _user.bind_cpb = self.bind_cpb;
    _user.bind_cpb_tblid = self.bind_cpb_tblid;
    _user.create_time = self.create_time;
    _user.nicknm_status = self.nicknm_status;
    _user.session_id = self.session_id;
    _user.phone_num = self.phone_num;
    [_user commit];
}

-(BOOL)hasLogin{
    if (self.uid!=nil && ![self.uid isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods
@end
