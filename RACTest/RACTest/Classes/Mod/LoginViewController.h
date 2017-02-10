//
//  LoginViewController.h
//  RACTest
//
//  Created by  rjt on 17/2/7.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface LoginViewController : AppViewController{
    LoginViewModel *_viewModel;
}

+(instancetype)controllerWithViewModel:(LoginViewModel*)viewModel;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(LoginViewModel*)viewModel;

@property (weak, nonatomic) IBOutlet UIView *cpbView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *verifyView;

@property (weak, nonatomic) IBOutlet UIView *viewIdentify;

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;       //输入的手机号
@property (weak, nonatomic) IBOutlet UITextField *password;       //输入的密码
@property (weak, nonatomic) IBOutlet UITextField *identifyCode;   //验证码
@property (weak, nonatomic) IBOutlet UIImageView *identifyImage;  //验证码图片

@property (weak, nonatomic) IBOutlet UIButton *loginButton;         //登陆
@end
