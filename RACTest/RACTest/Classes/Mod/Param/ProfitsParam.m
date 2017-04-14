//
//  ProfitsParam.m
//  TPZ
//
//  Created by chenyi on 16/2/26.
//  Copyright © 2016年 JYZD. All rights reserved.
//
#import "ProfitsParam.h"
#import "ProfitsEntity.h"

@implementation ProfitsParam

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(NSString *)getPath{
    return @"/product/profit";
}

-(Class)getEntityClass{
    return [ProfitsEntity class];
}

@end


