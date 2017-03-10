//
//  VerifySecurityCodeParam.m
//  RACTest
//
//  Created by  rjt on 17/2/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "VerifySecurityCodeParam.h"

@implementation VerifySecurityCodeParam
-(NSString *)getPath{
    return @"/user/verifysecuritycode";
}
-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}
@end
