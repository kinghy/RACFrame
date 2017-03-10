//
//  GetTimeMock.m
//  TPZ
//
//  Created by chenyi on 16/3/2.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "ServerTimeParam.h"
#import "ServerTimeEntity.h"

@implementation ServerTimeParam

-(NSString *)getPath{
    return @"/public/get_time";
}

-(Class)getEntityClass{
    return [ServerTimeEntity class];
}


@end
