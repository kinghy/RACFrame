//
//  MyStrategyViewModel.m
//  RACTest
//
//  Created by  rjt on 17/3/3.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "MyStrategyViewModel.h"
#import "MyAllListParam.h"
#import "MyAllListEntity.h"

@implementation MyStrategyViewModel
+(instancetype)viewModelWithType:(NSString*)type{
    MyStrategyViewModel* model = [[MyStrategyViewModel alloc] initWithType:type];
    return model;
}

-(instancetype)initWithType:(NSString*)type{
    if(self = [super init]){
        _type = type;
        _stopSubject = [RACSubject subject];
    }
    return self;
}

-(void)viewModelDidLoad{
    [super viewModelDidLoad];
}

-(void)renew{
    return [self refresh:@"0"];
}

-(void)turning{
    MyAllListRecordsEntity *e =  [self.dataSource.records lastObject];
    return [self refresh:(e==nil)?@"0":e.ID];
}

-(void)refresh:(NSString *)startid{
    MyAllListParam *param = [MyAllListParam new];
    param.start_id = startid;
    param.type = self.type;
    param.limit = kListLimit;
    RACSignal* signal = [[RFNetAdapter netAdapterWithParam:param].signal map:^id(id value) {
        NSMutableArray * arr = [NSMutableArray array];
        if([value isKindOfClass:[MyAllListEntity class]]) {
            [arr addObjectsFromArray:[(MyAllListEntity*)value records]];
        }
        return arr;
    }];
    BOOL clear = [startid isEqualToString:@"0"];
    [self.dataSource refresh:signal andClear:clear];
    
//    [self recompareProfits:[self refreshProfits]];//立刻触发一次
//    [self startRefreshProfit];

}

//-(RACSignal *)refreshProfits{
//    #warning 暂时去除刷行情
////    if(self.list && self.list.count>0){
////        NSMutableArray *id_arr = [NSMutableArray array];
////        
////        for(MyAllListRecordsEntity * e in _list){
////            [id_arr addObject:e.ID];
////        }
////        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
////            [[ProductsManager shareProductsManager] refreshProfitByIds:id_arr andBlock:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
////                if (val.result && [entity isKindOfClass:[ProfitEntity class]]) {
////                    ProfitEntity* pe = (ProfitEntity*)entity;
////                    [subscriber sendNext:pe.records];
////                    [subscriber sendCompleted];
////                }else{
////                    [subscriber sendError:NetError([mock getOperatorType],val)];
////                }
////            }];
////            return nil;
////        }];
////        
////    }
//    return nil;
//}
//
//-(void)recompareProfits:(RACSignal *)signal{
//#warning 暂时去除刷行情
////    @weakify(self)
////    [signal subscribeNext:^(NSArray *profits) {
////        @strongify(self)
////        for(ProfitRecordsEntity *e in profits){
////            for (MyAllListRecordsEntity *se in self.list) {
////                if([se.ID isEqualToString:e.key_id]){
////                    se.profitEntity = e;
////                    break;
////                }
////            }
////        }
////        self.refreshFlg = @"OK";
////    }];
//}
//
//-(void)stopRefreshProfit{
//    [_stopSubject sendNext:nil];
//    [_stopSubject sendCompleted];
//}
//
//-(void)startRefreshProfit{
//    //停止前一个
//    [_stopSubject sendNext:nil];
//    [_stopSubject sendCompleted];
//    //启动新一个
//    @weakify(self)
//    RACSignal *refreshSignal = [[[RACSignal interval:3 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:_stopSubject]  flattenMap:^id(id value) {
//        @strongify(self)
//        return [self refreshProfits];
//    }];
//    
//    [self recompareProfits:refreshSignal];
//}
@end
