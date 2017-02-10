//
//  LoginEntity.h
//  RACFrame
//
//  Created by  rjt on 17/2/4.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginEntity : NSObject
@property (strong,nonatomic) NSString *result;
@property (strong,nonatomic) NSString *error_code;//	0:登录成功 79001:失败 79002:失败次数过多，需要验证码 79003:失败次数过多，帐户被锁定	Int
@property (strong,nonatomic) NSString *uid;//		用户UID	Int
@property (strong,nonatomic) NSString *session_id;//		会话ID	String
@property (strong,nonatomic) NSString *encryptedKey;//		签名加密串	String
@property (strong,nonatomic) NSString *failed_times;//		密码输入错误次数	int
@end
