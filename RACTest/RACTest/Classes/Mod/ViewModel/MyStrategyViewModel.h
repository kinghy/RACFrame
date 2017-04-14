//
//  MyStrategyViewModel.h
//  RACTest
//
//  Created by  rjt on 17/3/3.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfitsViewModel.h"

@class MyAllListRecordsEntity;
@interface MyStrategyViewModel : AppListViewModel{
    RACSubject *_stopSubject;
    ProfitsViewModel *_pViewModel;
}

@property (nonatomic,strong)NSString *type;

@property (nonatomic,strong)NSString *refreshFlg;


+(instancetype)viewModelWithType:(NSString*)type;

-(instancetype)initWithType:(NSString*)type;


@end
