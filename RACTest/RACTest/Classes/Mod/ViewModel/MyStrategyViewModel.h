//
//  MyStrategyViewModel.h
//  RACTest
//
//  Created by  rjt on 17/3/3.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyAllListRecordsEntity;
@interface MyStrategyViewModel : NSObject{
    RACSubject *_stopSubject;
}

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *refreshFlg;

@property (nonatomic,strong)NSMutableArray<MyAllListRecordsEntity*> *list;//不要RACObserver此属性

+(instancetype)viewModelWithType:(NSString*)type;

-(instancetype)initWithType:(NSString*)type;

-(RACSignal*)renewList;
-(RACSignal*)refreshList;
-(RACSignal*)refreshProfits;
-(void)stopRefreshProfit;//停止刷新浮盈
-(void)startRefreshProfit;//停止刷新浮盈

-(void)clearList;

@end
