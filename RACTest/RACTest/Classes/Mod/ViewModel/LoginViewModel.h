//
//  LoginViewModel.h
//  RACTest
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserViewModel;
@interface LoginViewModel : AppViewModel
@property (strong,nonatomic) UserViewModel* user;
@property (strong,nonatomic) NSString* phoneNum;
@property (strong,nonatomic) NSString* password;
@property (strong,nonatomic) NSString* verifyCode;
@property (strong,nonatomic) UIImage* verfyImage;

@property (strong,nonatomic) RACCommand* loginCmd;

/**
 刷新验证图片
 */
- (void)refreshVerifyPic;

@end
