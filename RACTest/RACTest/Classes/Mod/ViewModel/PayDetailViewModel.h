//
//  PayDetailViewModel.h
//  STO
//
//  Created by  rjt on 16/12/29.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayDetailViewModel : AppViewModel

+(instancetype)viewModelWithPid:(NSString *)pid andPType:(NSString*)ptype;

-(instancetype)initWithPid:(NSString*)pid andPType:(NSString*)ptype;

-(void)loadViewModel;

-(RACSignal *)doSettle;

-(void)refresh;

@property (nonatomic,strong)RACCommand *doCommand;
@property (nonatomic,strong)RACCommand *dissentCommand;
@property (nonatomic,strong)RACCommand *doDissentCommand;

@property (nonatomic,strong)NSString *userProfit;
@property (nonatomic,strong)NSString *dissentTime;//异议申请时间
@property (nonatomic,strong)NSString *dissentFlg;//异议标志

@property (nonatomic,strong)NSString *stockName;
@property (nonatomic,strong)NSString *stockCode;
@property (nonatomic,strong)NSString *limit;//股票期限
@property (nonatomic,strong)NSString *buyWay;//委托方式
@property (nonatomic,strong)NSString *amount;//股票数量
@property (nonatomic,strong)NSString *fund;//买入金额
@property (nonatomic,strong)NSString *sellFund;//卖出金额
@property (nonatomic,strong)NSString *profit;//执行金额
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *stateName;
@property (nonatomic,strong)NSString *pID;
@property (nonatomic,strong)NSString *pType;

@property (nonatomic,strong)NSString *pno;
@property (nonatomic,strong)NSString *startPrice;
@property (nonatomic,strong)NSString *sellStartPrice;
@property (nonatomic,strong)NSString *stopLossPoint;
@property (nonatomic,strong)NSString *settlemntFlag;
@property (nonatomic,strong)NSString *infoFee;

@property (nonatomic,strong)NSString *winProfitRate;//合作回报比例

//异议
@property (nonatomic,strong)NSString *dissentPointStr;
@property (nonatomic,strong,readonly)NSString *dissentPoint;
@property (nonatomic,strong)NSString *dissentReasonText;
@property (nonatomic,strong)NSString *dissentValue;
@property (nonatomic,strong)NSDictionary<NSString*,NSString*> *dissentPointDict;
@property (nonatomic,strong)NSString *dissentCurrentValue;

@end
