//
//  UIAlertView+RF.h
//  RACFrame
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (RF)
+(instancetype)alertOneBtnWithWithTitle:(NSString *)title message:(NSString *)msg btnTitle:(NSString *)btnTitle clickedBlock:(void(^)(int value))block;
@end
