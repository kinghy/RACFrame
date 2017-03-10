//
//  OrderDetailsMock.m
//  STO
//
//  Created by admin on 2017/1/6.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "OrderDetailsParam.h"
#import "OrderDetailsEntity.h"

@implementation OrderDetailsParam

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodPost;
}

-(NSString *)getPath{
    return @"/product/orderdetails";
}

-(Class)getEntityClass{
    return [OrderDetailsEntity class];
}




@end
