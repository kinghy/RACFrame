//
//  UIView+HUD.h
//  RACFrame
//
//  Created by  rjt on 17/2/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 HUD扩展，基于MBProgressHUD
 */
@interface UIView (HUD)
-(void)showWaiting;
-(void)showWaiting:(NSString*)title;
-(void)hideWaiting;
@end
