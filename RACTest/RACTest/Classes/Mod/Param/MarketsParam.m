//
//  MarketsParam.m
//  RACTest
//
//  Created by  rjt on 17/5/26.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "MarketsParam.h"
#import "MarketsEntity.h"

@implementation MarketsParam
-(NSString *)opt{
    return @"gethqs";
}

-(NSString *)type{
    return @"SDBF";
}

-(NSString*)getPath{
    return @"";
}

-(NSString *)getDomain{
    return kMarketDomian;
}


- (Class)getEntityClass{
    return [MarketsEntity class];
}
@end
