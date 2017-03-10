//
//  LoginAgainViewController.h
//  RACTest
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewController.h"

@class LoginViewModel;

@interface LoginAgainViewController : AppViewController
+(instancetype)controllerWithViewModel:(LoginViewModel*)viewModel;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(LoginViewModel*)viewModel;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *verifyView;

@property (weak, nonatomic) IBOutlet UIView *viewIdentify;
@property (weak, nonatomic) IBOutlet UITextField *password;       //输入的密码
@property (weak, nonatomic) IBOutlet UITextField *identifyCode;   //验证码
@property (weak, nonatomic) IBOutlet UIImageView *identifyImage;  //验证码图片

@property (weak, nonatomic) IBOutlet UIButton *loginButton;         //登陆

@end
