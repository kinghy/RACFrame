//
//  HandicapParam.m
//  RACTest
//
//  Created by  rjt on 17/5/25.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "HandicapParam.h"
#import "HandicapEntity.h"

@implementation HandicapParam
-(NSString *)opt{
    return @"gethq";
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
    return [HandicapEntity class];
}


@end
