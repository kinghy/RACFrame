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
#import "ProfitsEntity.h"

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
    _pViewModel = [ProfitsViewModel viewModelWithInterval:3];
    [_pViewModel startRefreshProfit];
    RAC(_pViewModel,pIdArray)= [self.dataSource.recordsSignal map:^id(NSArray *array) {
        NSMutableArray *arr = [NSMutableArray array];
        for(MyAllListRecordsEntity *e in array){
            [arr addObject:e.ID];
        }
        return [NSArray arrayWithArray:arr];
    }];
    @weakify(self)
    [_pViewModel.dataSource.recordsSignal subscribeNext:^(NSArray* x) {
        @strongify(self)

        NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataSource.records];
        for(MyAllListRecordsEntity *e in array){
            for(ProfitsRecordsEntity *r in x){
                if([r.key_id isEqualToString:e.ID]){
                    e.profitEntity = r;
                }
            }
        }
        [self.dataSource refresh:[RACSignal return:array] andClear:YES ];
    }];
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

}

@end
