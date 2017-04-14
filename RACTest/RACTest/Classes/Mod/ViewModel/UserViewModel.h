//
//  UserViewModel.h
//  RACTest
//
//  Created by  rjt on 17/2/28.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewModel.h"

@interface UserViewModel : AppViewModel

+(instancetype)sharedInstance;

-(void)update;
-(void)save;
-(void)logout;
-(BOOL)hasLogin;

@property(strong,nonatomic)NSString* uid;
@property(strong,nonatomic)NSString* nick_name;
@property(strong,nonatomic)NSString* user_type;
@property(strong,nonatomic)NSString* bind_mobile;
@property(strong,nonatomic)NSString* bind_mail;
@property(strong,nonatomic)NSString* bind_weixin;
@property(strong,nonatomic)NSString* pic;    //头像地址
@property(strong,nonatomic)NSString* bind_prod;
@property(strong,nonatomic)NSString* bind_prod_tblid;
@property(strong,nonatomic)NSString* prod_username;
@property(strong,nonatomic)NSString* bind_cpb;
@property(strong,nonatomic)NSString* bind_cpb_tblid;
@property(strong,nonatomic)NSString* create_time;
@property(strong,nonatomic)NSString* nicknm_status;//昵称状态，2为审核拒绝

@property(strong,nonatomic)NSString* session_id;
@property(strong,nonatomic)NSString* phone_num;

@end
