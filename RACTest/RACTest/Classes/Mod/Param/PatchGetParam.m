//
//  PatchGetParam.m
//  RACTest
//
//  Created by  rjt on 17/4/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "PatchGetParam.h"
#import "PatchGetEntity.h"

@implementation PatchGetParam

-(RFNetWorkingMethod)getMethod{
    return RFNetWorkingMethodGet;
}

- (NSString *)getPath{
    return @"/update/patchget";
}

- (Class)getEntityClass{
    return [PatchGetEntity class];
}
@end
