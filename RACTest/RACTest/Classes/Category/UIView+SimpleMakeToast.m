//
//  UIView+SimpleMakeToast.m
//  RACTest
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIView+SimpleMakeToast.h"

@implementation UIView (SimpleMakeToast)
-(void)makeQuickToast:(NSString *)message{
    [self endEditing:YES];
    [self makeToast:message duration:1.f position:[CSToastManager defaultPosition] style:nil];
}

-(void)makeQuickToast:(NSString *)message duration:(NSTimeInterval)duration{
    [self endEditing:YES];
    [self makeToast:message duration:duration position:[CSToastManager defaultPosition] style:nil];
}
@end
