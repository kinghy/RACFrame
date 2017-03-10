//
//  UIView+Circle.m
//  RACFrame
//
//  Created by  rjt on 17/2/24.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIView+Circle.h"

@implementation UIView (Circle)
// 设置圆角
-(void)circleWithBorderColor:(UIColor*)color andWidth:(CGFloat)width{
    CALayer* layer = self.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = layer.frame.size.width/2;
    layer.borderColor = color.CGColor;
    layer.borderWidth = width;
}
@end
