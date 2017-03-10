//
//  DoSettleMock.m
//  TPZ
//
//  Created by chenyi on 16/3/2.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "DoSettleParam.h"
#import "DoSettleEntity.h"

@implementation DoSettleParam

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(NSString *)getPath{
    return @"/product/do_settle";
}

-(Class)getEntityClass{
    return [DoSettleEntity class];
}
@end
