//
//  PayViewModel.h
//  STO
//
//  Created by  rjt on 16/12/28.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SettlementsRecordsEntity;
@interface PayViewModel : AppViewModel

@property (nonatomic,strong)NSMutableArray<SettlementsRecordsEntity*> *payList;//不要RACObserver此属性

-(RACSignal*)renewPayList;
-(RACSignal*)refreshPayList;
-(RACSignal*)doSettleWithId:(NSString*)pid andType:(NSString*)ptype;
-(RACCommand*)bindDoSettleWithId:(NSString*)pid andType:(NSString*)ptype;

@end
