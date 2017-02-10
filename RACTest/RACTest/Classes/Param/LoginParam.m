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

-(NSString *)getPath{
    return @"/user/loginMask";
}

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(NSString *)password{
    return [_password sha1];
}
@end
