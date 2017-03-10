//
//  ProfitsViewModel.m
//  RACTest
//
//  Created by  rjt on 17/3/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "ProfitsViewModel.h"

@implementation ProfitsViewModel
-(void)renew{
    SettlementsParam *p = [SettlementsParam new];
    p.start_id = startid;
    p.limit = kArrayLimit;
    RACSignal* signal = [[RFNetAdapter netAdapterWithParam:p].signal map:^id(id value) {
        NSMutableArray * arr = [NSMutableArray array];
        if([value isKindOfClass:[SettlementsEntity class]]) {
            [arr addObjectsFromArray:[(SettlementsEntity*)value records]];
        }
        return arr;
    }];
    BOOL clear = [startid isEqualToString:@"0"];
    [self.dataSource refresh:signal andClear:clear];
}

-(void)turning{
    [self renew];
}
@end
