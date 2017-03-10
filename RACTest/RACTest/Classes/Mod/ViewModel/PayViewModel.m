//
//  PayViewModel.m
//  STO
//
//  Created by  rjt on 16/12/28.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "PayViewModel.h"
#import "SettlementsEntity.h"
#import "SettlementsParam.h"
#import "DoSettleParam.h"

@implementation PayViewModel

-(void)renew{
    [self refresh:@"0"];
}

-(void)turning{
    SettlementsRecordsEntity *e =  [self.dataSource.records lastObject];
    [self refresh:(e==nil)?@"0":e.ID];
}

-(void)refresh:(NSString *)startid{
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

-(RACSignal *)doSettleWithId:(NSString *)pid andType:(NSString *)ptype{
    DoSettleParam *param = [DoSettleParam new];
    param.p_id = pid;
    param.p_type = ptype;
    RACSignal* signal = [RFNetAdapter netAdapterWithParam:param].signal;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [signal subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];

}

-(RACCommand *)bindDoSettleWithId:(NSString *)pid andType:(NSString *)ptype{
    @weakify(self)
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self doSettleWithId:pid andType:ptype];
    }];
}
@end
