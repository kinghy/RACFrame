//
//  UIViewController+Nav.h
//  RACFrame
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Nav)

-(void)leftNavBtnWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;

//默认左侧按钮返回动作
-(void)leftBackBtnWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted;

-(void)rightNavBtnWithIcon:(NSString *)icon highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action;

-(void)leftNavBtnClicked:(id)sender;

-(void)navigationBarHidden:(BOOL)hide statusBarStyle:(UIStatusBarStyle)stytle title:(NSString*)title;

@end
