//
//  UserInfoEntity.h
//  QianFangGuJie
//
//  Created by 李荣 on 15/1/20.
//  Copyright (c) 2015年 余龙. All rights reserved.
//

@interface UserInfoEntity : NSObject
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
@end
