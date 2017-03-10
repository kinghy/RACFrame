//
//  ServerViewModel.m
//  RACTest
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "ServerViewModel.h"
#import "ServerTimeParam.h"
#import "ServerTimeEntity.h"

@interface ServerViewModel()
@property (nonatomic) NSInteger cacheTime;
@property (nonatomic) NSInteger localTime;
@end

@implementation ServerViewModel

+(instancetype)sharedInstance{
    static ServerViewModel *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(NSInteger)serverTime{
    return ([[NSDate date] timeIntervalSince1970] - self.localTime)+self.cacheTime;
}

-(void)updateServerTime{
    @weakify(self);
    RACSignal *signal = [RFNetAdapter netAdapterWithParam:[ServerTimeParam new]].signal;
    [signal subscribeNext:^(id x) {
        @strongify(self)
        if ([x isKindOfClass:[ServerTimeEntity class]]) {
            ServerTimeEntity*  e = (ServerTimeEntity*)x;
            if ([e.time integerValue]>0) {
                self.cacheTime = [e.time integerValue];
                self.localTime = [[NSDate date] timeIntervalSince1970];
            }
        }
    } error:^(NSError *error) {
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateServerTime];
        });
    }];
}
@end
