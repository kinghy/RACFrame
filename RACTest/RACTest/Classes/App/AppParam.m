//
//  AppParam.m
//  RACTest
//
//  Created by  rjt on 17/2/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppParam.h"


@implementation AppParam

-(NSString *)getDomain{
    return @"http://192.168.6.111:8116";
}

-(NSDictionary *)getHeaders{
    return @{@"x-qfgj-ua":@"STO/v_2.1.1 (iPhone Simulator; iOS 8.4; Scale/2.00)",@"x-qfgj-did":@"64de0956f0e511ef54b92033ff5f4e2cc1678e55",@"x-qfgj-sid":@"",@"x-qfgj-uid":@""};
}

-(BOOL)isResultValid:(id)result error:(NSError *__autoreleasing *)error{
    if([result isKindOfClass:[NSDictionary class]]){
        if([@"N" isEqualToString:[result objectForKey:@"result"]] || [[result objectForKey:@"error_code"] integerValue]>0){
            *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@",[self class]] code:kNetErrorUnexpectable userInfo:@{kErrorMsg:[result objectForKey:@"error_msg"],kErrorCode:[result objectForKey:@"error_code"]}];
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
