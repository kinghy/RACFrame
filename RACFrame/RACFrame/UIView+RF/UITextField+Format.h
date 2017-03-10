//
//  UITextField+Format.h
//  RACFrame
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Format)
-(void)numberFormatWithDelegate:(id<UITextFieldDelegate>)delegate;
-(void)mobileFormatWithDelegate:(id<UITextFieldDelegate>)delegate;
@end
