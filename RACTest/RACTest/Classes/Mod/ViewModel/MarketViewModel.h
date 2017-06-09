//
//  MarketViewModel.h
//  RACTest
//
//  Created by  rjt on 17/5/25.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppParam.h"

@interface MarketViewModel : AppParam
-(RACSignal*)refreshMarketsWithIds:(NSArray*)ids andInterval:(NSInteger)interval takeUntil:(RACSignal*)untilSignal;
-(RACSignal*)refreshSHMarketWithInterval:(NSInteger)interval takeUntil:(RACSignal*)untilSignal;
@end
