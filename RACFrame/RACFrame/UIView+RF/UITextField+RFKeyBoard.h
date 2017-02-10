//
//  UITextField+RFKeyBoard.h
//  RACFrame
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 键盘扩展
 */
@interface UITextField (RFKeyBoard)

/**
 被遮盖时自动调整输入框位置,为了避免产生bug请需要开启一个textField自动调整时 同时开启当前页面所有textField的自动调整功能
 */
-(void)autoAdjustCovered;
@end
