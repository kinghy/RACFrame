//
//  LoginViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/7.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    LoginViewModel *_viewModel;
}

- (IBAction)backClicked:(id)sender;
//切换使用手机登录
- (IBAction)phoneLoginClicked:(id)sender;
//切换使用操盘宝登录
- (IBAction)cpbLoginClicked:(id)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:YES];
    
    //开启自动收起键盘
    [self.view autoHideKeyBoard];
    //开启自动调整
    [self.password autoAdjustCovered];
    [self.identifyCode autoAdjustCovered];
    [self.phoneNum autoAdjustCovered];
    
    //默认收起验证框
    [self.verifyView setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init methods

+(instancetype)controllerWithViewModel:(LoginViewModel*)viewModel{
    LoginViewController *c = [[self alloc] initWithNibName:[[self class] description] bundle:nil viewModel:viewModel];
    return c;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(LoginViewModel*)viewModel{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - extends methods
-(void)formatView{
    [self.loginButton cornerButton];
    [self.cpbLoginButton cornerButton];
    [self.cpbRegisterButton cornerButton];
    
    self.phoneNum.placeholder = @"手机号";
    //格式化手机字符串
    [self.phoneNum mobileFormatWithDelegate:self];
    
    [self.password setSecureTextEntry:YES];//密文
    self.password.placeholder = @"密码";
    //格式化密码
    [[self.password rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField* x){
        x.text = [x.text formatPassword];
    }];
    
    //格式化验证码
    [[self.identifyCode rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField* x){
        x.text = [x.text formatVerifyCode];
    }];
    
    //登录操作
    self.loginButton.rac_command = _viewModel.loginCmd;
    @weakify(self);
    
    [[self.loginButton.rac_command.executionSignals flatten]subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.loginButton.rac_command.executing subscribeNext:^(id x) {
        @strongify(self);
        [x boolValue] ?[self.view showWaiting]:[self.view hideWaiting];
    }];
    
    [self.loginButton.rac_command.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        NSString *errorMsg = error.userInfo[kErrorMsg];
        [self.view makeQuickToast:errorMsg];
        [self.view hideWaiting];
        
        NSString *errorCode = [NSString stringWithFormat:@"%@",error.userInfo[kErrorCode]];
        if([errorCode isEqualToString:@"79002"]){
            [self.verifyView setHidden:NO];
        }
    }];
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshVerifyPic)];
    self.identifyImage.userInteractionEnabled = YES;
    [self.identifyImage addGestureRecognizer:gest];
}

-(void)bindViewModel{

    RAC(_viewModel,phoneNum) = [self.phoneNum.rac_textSignal map:^id(id value) {
        //去空格
        return [value stringByReplacingOccurrencesOfString:@" " withString:@""];
    }];
    
    RAC(_viewModel,password) = self.password.rac_textSignal;
    RAC(_viewModel,verifyCode) = self.identifyCode.rac_textSignal;
    
    RAC(self.identifyImage,image) = RACObserve(_viewModel, verfyImage);

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:YES statusBarStyle:UIStatusBarStyleLightContent title:nil];
}
#pragma mark - public methods

#pragma mark - private methods

-(void)refreshVerifyPic{
    [_viewModel refreshVerifyPic];
}

#pragma mark - delegate methods

#pragma mark - Action methods

- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)phoneLoginClicked:(id)sender {
    self.middleView.hidden = NO;
    self.bottomView.hidden = NO;
    self.cpbView.hidden = YES;
}

- (IBAction)cpbLoginClicked:(id)sender {
    self.middleView.hidden = YES;
    self.bottomView.hidden = YES;
    self.cpbView.hidden = NO;
}

@end
