//
//  MyAllListParam.m
//  STO
//
//  Created by chenyi on 16/6/27.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "MyAllListParam.h"
#import "MyAllListEntity.h"

@implementation MyAllListParam
-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(NSString *)getPath{

    return @"/product/getmyalllist";
}

-(Class)getEntityClass{

    return [MyAllListEntity class];
}


@end
