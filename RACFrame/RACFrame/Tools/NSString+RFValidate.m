//
//  NSString+RFValidate.m
//  RACFrame
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "NSString+RFValidate.h"

@implementation NSString (RFValidate)

#pragma mark - init methods

#pragma mark - extends methods

#pragma mark - public methods
- (BOOL)validateNumber {
#warning 真机上有问题
    NSString *re = @"^[-]?\\d*[.]?\\d*$";
    NSRange range = [self rangeOfString:re options:NSRegularExpressionSearch];
    return range.location != NSNotFound ;
}

-(BOOL)validateInputMobile{
    
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * regex = @"^[0-9]{0,11}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
}

/**  格式化手机号 */
- (NSString *)formatMobile{
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(str.length>7){
        str = [NSString stringWithFormat:@"%@ %@ %@",[str substringToIndex:3],[str substringWithRange:NSMakeRange(3, 4)],[str substringWithRange:NSMakeRange(7, str.length-7)]];
    }else if(str.length>3){
        str = [NSString stringWithFormat:@"%@ %@",[str substringToIndex:3],[str substringWithRange:NSMakeRange(3, str.length-3)]];
    }
    return str;
}

#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods
@end
