//
//  IndexViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/15.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "IndexViewController.h"
#import "PayViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "PayViewModel.h"
#import "UserViewModel.h"
#import "STOSearchViewController.h"

#define kDockItemHome 0
#define kDockItemPublish 1
#define kDockItemExcute 2
#define kDockItemPay 3

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UINavigationController *hc = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    hc.tabBarItem.title=@"首页";
    hc.tabBarItem.image=[UIImage imageNamed:@"tab_1"];
    hc.tabBarItem.tag = kDockItemHome;
    
    UINavigationController *bc = [[UINavigationController alloc] initWithRootViewController:[[STOSearchViewController alloc] init]];
    bc.tabBarItem.title=@"建策略";
    bc.tabBarItem.image=[UIImage imageNamed:@"tab_2"];
    bc.tabBarItem.tag = kDockItemPublish;

    UINavigationController *dc = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    dc.tabBarItem.title=@"订执行";
    dc.tabBarItem.image=[UIImage imageNamed:@"tab_3"];
    dc.tabBarItem.tag = kDockItemExcute;
    
    UINavigationController *pc = [[UINavigationController alloc] initWithRootViewController:[PayViewController controllerWithViewModel:[PayViewModel new]]];
    pc.tabBarItem.title=@"收付款";
    pc.tabBarItem.image=[UIImage imageNamed:@"tab_4"];
    pc.tabBarItem.tag = kDockItemPay;
    self.viewControllers = @[hc,bc,dc,pc];
    
    self.delegate = self;
    self.tabBar.translucent = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:YES statusBarStyle:UIStatusBarStyleDefault title:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - init methods

#pragma mark - extends methods

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - delegate methods
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    UserViewModel *user = [UserViewModel sharedInstance];
    
    if(viewController.tabBarItem.tag == kDockItemPay){

        if(![user hasLogin]){
            [[NSNotificationCenter defaultCenter] postNotificationName:kGlobalLogin object:nil];
            return NO;
        }
    }
    return YES;
}
#pragma mark - Action methods
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
