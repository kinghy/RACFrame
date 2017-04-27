//
//  STOSearchViewModel.m
//  RACTest
//
//  Created by  rjt on 17/4/25.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "STOSearchViewModel.h"
#import "RFDBPersistManager.h"
#import "StockPersistance.h"

@implementation STOSearchViewModel
-(void)viewModelDidLoad{
    [super viewModelDidLoad];
    
    RACSignal *signal = [[RACObserve(self, keywords) filter:^BOOL(NSString* value) {
        return value.length>0;
    }] map:^id(NSString* value) {
        return [[RFDBPersistManager sharedInstace] persistancesByClass:[StockPersistance class] andQuery:kStockFuzzyQuery(value)];
    }];
    
    [self.dataSource refresh:signal andClear:YES];
    
}

@end
