//
//  RFDataSource.m
//  RACFrame
//
//  Created by  rjt on 17/3/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFDataSource.h"


@implementation RFDataSource
-(instancetype)init{
    if(self=[super init]){
        _records = [NSMutableArray array];
        _recordsSignal = [RACSubject subject];
        _errorsSignal = [RACSubject subject];
    }
    return self;
}

-(void)refresh:(RACSignal *)arraySignal andClear:(BOOL)clear{
    @weakify(self);
    [arraySignal subscribeNext:^(NSArray *x) {
        @strongify(self);
        NSMutableArray *records = [self mutableArrayValueForKey:@"records"];
        if(clear){
            [records removeAllObjects];
        }
        [records addObjectsFromArray:x];
        [self.recordsSignal sendNext:records];
    } error:^(NSError *error) {
        @strongify(self);
        [self.errorsSignal sendNext:error];
    } completed:^{
    }];
    
}
@end
