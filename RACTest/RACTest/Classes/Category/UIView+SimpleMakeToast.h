//
//  UIView+SimpleMakeToast.h
//  RACTest
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 创建一个快速的toast，需要TToast框架支持https://github.com/scalessec/Toast
 */
@interface UIView (SimpleMakeToast)
- (void)makeQuickToast:(NSString *)message;
@end
