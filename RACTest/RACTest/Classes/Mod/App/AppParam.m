//
//  AppParam.m
//  RACTest
//
//  Created by  rjt on 17/2/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppParam.h"
#import "UserViewModel.h"

@implementation AppParam

-(NSString *)getDomain{
    NSString *url2 = kProductDomian;
    NSString *url = kUserDomian;
    
    NSString* strUrl = nil;
    if ([[self getPath] hasPrefix:@"/product/"]||[[self getPath] hasPrefix:@"/public"]||[[self getPath] hasPrefix:@"/stock/"]) {
        
        strUrl = url2;
    }  else {
        
        strUrl = url;
    }
    return strUrl;
}

-(NSDictionary *)getHeaders{
    UserViewModel *u = [UserViewModel sharedInstance];
    return @{@"x-qfgj-ua":@"STO/v_2.1.1 (iPhone Simulator; iOS 8.4; Scale/2.00)",@"x-qfgj-did":[OpenUDID value],@"x-qfgj-sid":u.session_id?u.session_id:@"",@"x-qfgj-uid":u.uid?u.uid:@""};
}

-(BOOL)isResultValid:(id)result error:(NSError *__autoreleasing *)error{
    if([result isKindOfClass:[NSDictionary class]]){
        if([@"N" isEqualToString:[result objectForKey:@"result"]] || [[result objectForKey:@"error_code"] integerValue]>0){
            if([[result objectForKey:@"error_code"] integerValue] == kNetErrorLoginExpired){
                [[NSNotificationCenter defaultCenter] postNotificationName:kGlobalLoginExpired object:nil];
            }
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
