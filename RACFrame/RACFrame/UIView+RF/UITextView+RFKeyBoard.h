//
//  UITextView+RFKeyBoard.h
//  RACFrame
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 键盘扩展
 */
@interface UITextView (RFKeyBoard)

/**
 被遮盖时自动调整输入框位置

 @param delegate UITextViewDelegate代理
 */
-(void)autoAdjustCoveredWithDelegate:(id<UITextViewDelegate>)delegate;
@end
