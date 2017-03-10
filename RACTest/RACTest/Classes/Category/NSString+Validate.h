//
//  NSString+Validate.h
//  RACTest
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)


/**
 格式化密码，允许输入18位以内的数字或字母

 @return 格式化后的密码
 */
- (NSString *)formatPassword;

/**
 格式化验证码，允许输入4位以内的数字或字母
 
 @return 格式化后的验证码
 */
- (NSString *)formatVerifyCode;

/**
 验证手机号码是否有效

 @return 是否有效
 */
- (BOOL)validateMobile;
/**
 验证密码是否有效

 @return 是否有效
 */
- (BOOL)validatePassword;

/**
 验证验证码是否有效

 @return 是否有效
 */
- (BOOL)validateVerifyCode;



@end
