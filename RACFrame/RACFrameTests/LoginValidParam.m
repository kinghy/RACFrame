//
//  LoginValidParam.m
//  RACFrame
//
//  Created by  rjt on 17/2/7.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "LoginValidParam.h"

@implementation LoginValidParam
-(BOOL)isResultValid:(id)result error:(NSError *__autoreleasing *)error{
    if([result isKindOfClass:[NSDictionary class]]){
        if([@"N" isEqualToString:[result objectForKey:@"result"]] || [[result objectForKey:@"error_code"] integerValue]>0){
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@",[self class]] code:kNetErrorUnexpectable userInfo:@{@"result":result}];
            return NO;
        }else{
            return YES;
        }
    }else{
        *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@",[self class]] code:kNetErrorUnexpectable userInfo:@{@"result":result}];
        return NO;
    }
}
@end
