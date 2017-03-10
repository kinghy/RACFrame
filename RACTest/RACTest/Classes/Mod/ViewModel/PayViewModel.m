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

-(void)viewModelDidLoad{
    _payList = [NSMutableArray array];
}

-(RACSignal*)renewPayList{
    return [self refresh:@"0"];
}

-(RACSignal*)refreshPayList{
    SettlementsRecordsEntity *e =  [_payList lastObject];
    return [self refresh:(e==nil)?@"0":e.ID];
}

-(RACSignal*)refresh:(NSString *)startid{
    @weakify(self);
    
    SettlementsParam *p = [SettlementsParam new];
    p.start_id = startid;
    p.limit = kArrayLimit;
    RACSignal* signal = [RFNetAdapter netAdapterWithParam:p].signal;
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [signal subscribeNext:^(id x) {
            @strongify(self);
            if([x isKindOfClass:[SettlementsEntity class]]) {
                SettlementsEntity *e = (SettlementsEntity*)x;
                NSMutableArray *payList = [self mutableArrayValueForKey:@"payList"];
                if([startid isEqualToString:@"0"]){
                    [payList removeAllObjects];
                }
                [payList addObjectsFromArray:e.records];
                id data = RACTuplePack(self.payList,e.records);
                [subscriber sendNext:data];
                [subscriber sendCompleted];
            }else{
    
            }
        } error:^(NSError *error) {
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];

        return nil;
    }];
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
