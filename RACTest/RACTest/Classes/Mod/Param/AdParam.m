//
//  AdParam.m
//  RACTest
//
//  Created by  rjt on 17/5/24.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AdParam.h"
#import "AdEntity.h"

@implementation AdParam
-(NSString *)type{
    return @"homepage_ad";
}

-(NSString*)getPath{
    return @"/newestinfo/ad";
}

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(Class)getEntityClass{
    return [AdEntity class];
}

@end
