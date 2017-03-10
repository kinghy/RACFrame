//
//  NSString+RFValidate.h
//  RACFrame
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RFValidate)
/**
 验证是否为数字
 
 @return 是否有效
 */
- (BOOL)validateNumber;

- (BOOL)validateInputMobile;

/**
 格式化手机号xxx xxxx xxxx
 
 @return 格式化后的手机号
 */
- (NSString *)formatMobile;
@end
