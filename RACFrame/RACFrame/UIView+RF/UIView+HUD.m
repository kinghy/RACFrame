//
//  UIView+HUD.m
//  RACFrame
//
//  Created by  rjt on 17/2/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)
-(void)showWaiting{
    [self showWaiting:nil];
}

-(void)showWaiting:(NSString*)title{
    [self endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
    hud.color = [UIColor blackColor];
    hud.activityIndicatorColor = [UIColor whiteColor];
//    hud.alpha = 0.8;
//    hud.customView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    if(title){
        hud.label.text = title;
        hud.label.textColor = [UIColor whiteColor];
    }
}
-(void)hideWaiting{
    [MBProgressHUD hideHUDForView:self animated:YES];
}
@end
