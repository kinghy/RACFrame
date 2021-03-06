//
//  AppViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self leftBackBtnWithIcon:@"nav_back" highlightedIcon:@"nav_back"];
    [self formatView];
    [self bindViewModel];
    self.navigationController.navigationBar.translucent = NO;//解决导航栏遮挡页面的问题
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

#pragma mark - extends methods

#pragma mark - public methods
-(void)bindViewModel{
}
-(void)formatView{
}
#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods
-(void)dealloc{
    DDLogInfo(@"%@ has dealloced",[self class]);
}
@end
