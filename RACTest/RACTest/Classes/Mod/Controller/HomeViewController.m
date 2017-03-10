//
//  HomeViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/24.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "HomeViewController.h"
#import "MineViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self leftNavBtnWithIcon:@"index_mine" highlightedIcon:@"index_mine" target:self action:@selector(mineBtnClicked:)];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:NO statusBarStyle:UIStatusBarStyleDefault title:@"首页"];
}
#pragma mark - public methods

#pragma mark - private methods
//我的按钮
- (void)mineBtnClicked:(UIButton *)btn{
#warning 注释
//    NSString *time=[NSString stringWithFormat:@"%ld",[[ProductsManager shareProductsManager]getServerTime]];
//    NSString *key = @"tab_mine_reset_time";
//    [[NSUserDefaults standardUserDefaults] setObject:time forKey:key];
//    [self.mineBtn setImage:[UIImage imageNamed:@"index_mine"] forState:UIControlStateNormal];
    MineViewController* mine = [[MineViewController alloc]initWithNibName:@"MineViewController" bundle:nil];
    [self.navigationController.navigationController pushViewController:mine animated:YES];
}
#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods
@end
