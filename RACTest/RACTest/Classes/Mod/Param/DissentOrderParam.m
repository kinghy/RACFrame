//
//  DissentOrderMock.m
//  QianFangGuJie
//
//  Created by 财道 on 15/1/14.
//  Copyright (c) 2015年 余龙. All rights reserved.
//

#import "DissentOrderParam.h"
#import "DissentOrderEntity.h"
@implementation DissentOrderParam
-(NSString*)getPath{
    return @"/public/dissent_order";
}

-(Class)getEntityClass{
    return [DissentOrderEntity class];
}

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

@end
