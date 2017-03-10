//
//  SettlementsParam.m
//  TPZ
//
//  Created by chenyi on 16/2/26.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "SettlementsParam.h"
#import "SettlementsEntity.h"


@implementation SettlementsParam

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(NSString *)getPath{
    return @"/product/settlements";
}

-(Class)getEntityClass{
    return [SettlementsEntity class];
}

@end



