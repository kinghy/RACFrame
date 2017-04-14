//
//  ProfitsViewModel.h
//  RACTest
//
//  Created by  rjt on 17/3/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewModel.h"

@interface ProfitsViewModel : AppListViewModel{
    NSInteger _interval;
    RACSubject *_stopSubject;
}

@property NSArray<NSString*> *pIdArray;

/**
 创建ProfitsViewModel，可定期刷新

 @param interval 定期刷新频率
 @return 生成的实例
 */
+(instancetype)viewModelWithInterval:(NSInteger)interval;

-(instancetype)initWithInterval:(NSInteger)interval;

-(void)stopRefreshProfit;
-(void)startRefreshProfit;
@end
