//
//  LoginAgainViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "LoginAgainViewController.h"
#import "LoginViewModel.h"
#import "UserViewModel.h"

@interface LoginAgainViewController (){
    LoginViewModel *_viewModel;
    UserViewModel *_user;
}
- (IBAction)backClicked:(id)sender;

@end

@implementation LoginAgainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:YES];
    
    //开启自动收起键盘
    [self.view autoHideKeyBoard];
    //开启自动调整
    [self.password autoAdjustCovered];
    [self.identifyCode autoAdjustCovered];
    
    //默认收起验证框
    [self.verifyView setHidden:YES];
    
    _user = [UserViewModel sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - init methods
+(instancetype)controllerWithViewModel:(LoginViewModel*)viewModel{
    LoginAgainViewController *c = [[self alloc] initWithNibName:[[self class] description] bundle:nil viewModel:viewModel];
    return c;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(LoginViewModel*)viewModel{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - extends methods
-(void)viewWillAppear:(BOOL)animated{    
    [self.headImg circleWithBorderColor:kLoginHeadBG andWidth:1];
    [self.loginButton cornerButton];
    [self navigationBarHidden:YES statusBarStyle:UIStatusBarStyleLightContent title:nil];
}

-(void)formatView{
    
    self.phoneLabel.text = _user.phone_num;
    
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
    
    _viewModel.phoneNum = _user.phone_num;
    
    RAC(_viewModel,password) = self.password.rac_textSignal;
    RAC(_viewModel,verifyCode) = self.identifyCode.rac_textSignal;
    
    RAC(self.identifyImage,image) = RACObserve(_viewModel, verfyImage);
    
}
#pragma mark - public methods

#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - get/set methods

@end
