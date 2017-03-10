//
//  NSString+Validate.m
//  RACTest
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "NSString+Validate.h"
#define kFilterNumber @"1234567890"
#define kFilterNumberDot @"-1234567890."
#define kFilterLetter @"abcdefghijklmnopqrstuvwxyz"
@implementation NSString (Validate)

#pragma mark - init methods

#pragma mark - extends methods

#pragma mark - public methods

-(NSString *)formatPassword{
    return [self filterPassword];
}

-(NSString *)formatVerifyCode{
    return [self filterVerifyCode];
}

-(BOOL)validateMobile{
    return (self.length==11) && [self validateInputMobile] && [self hasPrefix:@"1"];
}

-(BOOL)validatePassword{
    return self.length>=6 && self.length<=18 && [[self filterPassword] isEqualToString:self];
}

-(BOOL)validateVerifyCode{
    return self.length == 4 && [[self filterVerifyCode] isEqualToString:self];
}

#pragma mark - private methods

-(NSString*)filterPassword{
    //去除所有不是数字和字母的字符
    NSString* filter = [NSString stringWithFormat:@"%@%@%@",kFilterNumber,[kFilterLetter lowercaseString],[kFilterLetter uppercaseString]];
    NSCharacterSet *setToRemove =[[NSCharacterSet characterSetWithCharactersInString:filter] invertedSet ];
    NSString *str =[[self componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    
    //大于18就裁剪到18;
    if(str.length>18){
        str = [str substringToIndex:18];
    }
    return str;
}


-(NSString*)filterVerifyCode{
    //去除所有不是数字和字母的字符
    NSString* filter = [NSString stringWithFormat:@"%@%@%@",kFilterNumber,[kFilterLetter lowercaseString],[kFilterLetter uppercaseString]];
    NSCharacterSet *setToRemove =[[NSCharacterSet characterSetWithCharactersInString:filter] invertedSet ];
    NSString *str =[[self componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
    
    //大于18就裁剪到18;
    if(str.length>4){
        str = [str substringToIndex:4];
    }
    return str;
}
#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods
@end
