//
//  ProfitsViewModel.m
//  RACTest
//
//  Created by  rjt on 17/3/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "ProfitsViewModel.h"
#import "ProfitsParam.h"
#import "ProfitsEntity.h"

@implementation ProfitsViewModel
+(instancetype)viewModelWithInterval:(NSInteger)interval{
    return [[ProfitsViewModel alloc] initWithInterval:interval];
}

-(instancetype)initWithInterval:(NSInteger)interval{
    if(self=[super init]){
        _interval = interval;
        _stopSubject = [RACSubject subject];
    }
    return self;
}

-(void)renew{
    if(_pIdArray.count > 0){
        ProfitsParam *p = [ProfitsParam new];
        p.p_id_arr = [_pIdArray componentsJoinedByString:@","];
        RACSignal* signal = [[RFNetAdapter netAdapterWithParam:p].signal map:^id(id value) {
            NSMutableArray * arr = [NSMutableArray array];
            if([value isKindOfClass:[ProfitsEntity class]]) {
                [arr addObjectsFromArray:[(ProfitsEntity*)value records]];
            }
            return arr;
        }];
//        BOOL clear = [startid isEqualToString:@"0"];
        [self.dataSource refresh:signal andClear:NO];
    }
}

-(void)turning{
    [self renew];
}

-(void)stopRefreshProfit{
    [_stopSubject sendNext:nil];
    [_stopSubject sendCompleted];
}

-(void)startRefreshProfit{
    //停止前一个
    [_stopSubject sendNext:nil];
    [_stopSubject sendCompleted];
    //启动新一个
    @weakify(self)
    [[[RACSignal interval:3 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:_stopSubject] subscribeNext:^(id x) {
        @strongify(self);
        [self renew];
    }];
}
@end
