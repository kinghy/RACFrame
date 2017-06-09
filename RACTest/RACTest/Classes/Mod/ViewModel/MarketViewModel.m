//
//  MarketViewModel.m
//  RACTest
//
//  Created by  rjt on 17/5/25.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "MarketViewModel.h"
#import "HandicapParam.h"
#import "MarketsParam.h"

@implementation MarketViewModel
-(RACSignal *)refreshSHMarketWithInterval:(NSInteger)interval takeUntil:(RACSignal *)untilSignal{
    HandicapParam *param = [HandicapParam new];
    param.name = @"000001";
    param.excode = @"SH";
    RACSignal *timeSignal = [RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler]];
    if(untilSignal){
        timeSignal = [timeSignal takeUntil:untilSignal];
    }
    
    return [timeSignal flattenMap:^RACStream *(id value) {
        return [RFNetAdapter netAdapterWithParam:param].signal;
    }];
    
}

-(RACSignal *)refreshMarketsWithIds:(NSArray *)ids andInterval:(NSInteger)interval takeUntil:(RACSignal *)untilSignal{
    NSMutableString *code = [NSMutableString string];
    for(NSString* strID in ids){
        [code appendString:[NSString stringWithFormat:@"%@;",strID]];
    }
    
    MarketsParam *param = [MarketsParam new];
    param.name = code;
    RACSignal *timeSignal = [RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler]];
    if(untilSignal){
        timeSignal = [timeSignal takeUntil:untilSignal];
    }
    
    return [timeSignal flattenMap:^RACStream *(id value) {
        return [RFNetAdapter netAdapterWithParam:param].signal;
    }];
}
@end
