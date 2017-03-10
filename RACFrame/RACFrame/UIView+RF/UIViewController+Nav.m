//
//  UIViewController+Nav.m
//  RACFrame
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIViewController+Nav.h"

@implementation UIViewController (Nav)

-(void)leftBackBtnWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted{
    if([self.navigationController.childViewControllers count]>1){
        [self leftNavBtnWithIcon:icon highlightedIcon:highlighted target:self action:@selector(leftNavBtnClicked:)];
    }
}

-(void)leftNavBtnWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithIcon:icon highlightedIcon:highlighted target:target action:action];
}

-(void)rightNavBtnWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithIcon:icon highlightedIcon:highlighted target:target action:action];
}

-(void)leftNavBtnClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navigationBarHidden:(BOOL)hide statusBarStyle:(UIStatusBarStyle)stytle title:(NSString*)title{
    [self.navigationController setNavigationBarHidden:hide];
    //在info.plist文件中将View controller-based status bar appearance设置为NO
    [[UIApplication sharedApplication] setStatusBarStyle:stytle animated:NO];
    self.title = title;
}

@end
