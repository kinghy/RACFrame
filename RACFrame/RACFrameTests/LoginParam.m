//
//  LoginParam.m
//  RACFrame
//
//  Created by  rjt on 17/2/4.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "LoginParam.h"
#import "LoginEntity.h"
#import "NSString+SHA1.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "RFMacro.h"

@implementation LoginParam
-(Class)getEntityClass{
    return [LoginEntity class];
}
-(NSString *)getDomain{
    return @"http://192.168.6.111:8116";
}
-(NSString *)getPath{
    return @"/user/loginMask";
}

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(NSDictionary *)getHeaders{
    return @{@"x-qfgj-ua":@"STO/v_2.1.1 (iPhone Simulator; iOS 8.4; Scale/2.00)",@"x-qfgj-did":@"64de0956f0e511ef54b92033ff5f4e2cc1678e55",@"x-qfgj-sid":@"",@"x-qfgj-uid":@""};
}

-(NSString *)password{
    return [_password sha1];
}
@end
