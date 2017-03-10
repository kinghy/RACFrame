//
//  LoginParam.h
//  RACFrame
//
//  Created by  rjt on 17/2/4.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RFNetAdapter.h"

@interface LoginParam : NSObject<IRFParam>
@property (strong,nonatomic) NSString* logInID;//	手机号/UID	Int	TRUE
@property (strong,nonatomic) NSString* password;//	密码	sha1(String)	TRUE
@property (strong,nonatomic) NSString* logInType;//	1-手机的验证码登录、2-手机的安全码登录、3-操盘宝登录、6-UID登陆	Int	TRUE
@property (strong,nonatomic) NSString* version_client;//	客户端版本号	String	FALSE

@end
