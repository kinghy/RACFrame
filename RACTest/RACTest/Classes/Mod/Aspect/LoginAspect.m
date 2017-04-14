//
//  LoginAspect.m
//  RACFrame
//
//  Created by  rjt on 17/1/20.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "LoginAspect.h"
#import "DDLog.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "LoginAgainViewController.h"

@implementation LoginAspect

//注册
@REGISTER_AS_ASPECTS

#pragma mark - RFAppAspectInt methods
//实现切片
-(void)before_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAgain) name:kGlobalLoginExpired object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name:kGlobalLogin object:nil];
}

-(void)login{
    AppDelegate *d = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![[d.rootViewController.navigationController.viewControllers lastObject] isKindOfClass:[LoginViewController class]]) {
        [d.rootViewController pushViewController:[LoginViewController controllerWithViewModel:[LoginViewModel new]] animated:YES];
    }
}

-(void)loginAgain{
    AppDelegate *d = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (![[d.rootViewController.navigationController.viewControllers lastObject] isKindOfClass:[LoginAgainViewController class]]) {
        [d.rootViewController pushViewController:[LoginAgainViewController controllerWithViewModel:[LoginViewModel new]] animated:YES];
    }
}

@end
