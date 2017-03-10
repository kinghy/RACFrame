//
//  MyStrategyViewModel.h
//  RACTest
//
//  Created by  rjt on 17/3/3.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyAllListRecordsEntity;
@interface MyStrategyViewModel : AppListViewModel{
    RACSubject *_stopSubject;
}

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *refreshFlg;


+(instancetype)viewModelWithType:(NSString*)type;

-(instancetype)initWithType:(NSString*)type;

-(void)refreshProfits;
-(void)stopRefreshProfit;//停止刷新浮盈
-(void)startRefreshProfit;//停止刷新浮盈

@end
