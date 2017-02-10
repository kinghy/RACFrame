//
//  LoginViewModel.h
//  RACTest
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : AppViewModel
@property (strong,nonatomic) NSString* uid;
@property (strong,nonatomic) NSString* phoneNum;
@property (strong,nonatomic) NSString* password;
@property (strong,nonatomic) NSString* verifyCode;
@property (strong,nonatomic) UIImage* verfyImage;

@property (strong,nonatomic) RACCommand* loginCmd;

/**
 格式化手机号xxx xxxx xxxx,手机号必须以1开头

 @param string 格式化前的手机号
 @return 格式化后的手机号
 */
- (NSString *)formatMobile:(NSString *)string;


/**
 格式化密码，允许输入18位以内的数字或字母

 @param string 格式化前的密码
 @return 格式化后的密码
 */
- (NSString *)formatPassword:(NSString *)string;

/**
 格式化验证码，允许输入4位以内的数字或字母
 
 @param string 格式化前的验证码
 @return 格式化后的验证码
 */
- (NSString *)formatVerifyCode:(NSString *)string;

/**
 验证手机号码是否有效

 @param string 手机号
 @return 是否有效
 */
- (BOOL)validateMobile:(NSString *)string;
/**
 验证密码是否有效
 
 @param string 密码
 @return 是否有效
 */
- (BOOL)validatePassword:(NSString *)string;

/**
 验证验证码是否有效
 
 @param string 验证码
 @return 是否有效
 */
- (BOOL)validateVerifyCode:(NSString *)string;

/**
 刷新验证图片
 */
- (void)refreshVerifyPic;
@end
