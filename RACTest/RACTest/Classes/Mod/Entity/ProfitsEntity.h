//
//  ProfitsEntity.h
//  TPZ
//
//  Created by chenyi on 16/2/26.
//  Copyright © 2016年 JYZD. All rights reserved.
//

@class ProfitsRecordsEntity;
@interface ProfitsEntity : NSObject<IRFEntity>
@property (nonatomic,strong) NSArray<ProfitsRecordsEntity*> *records;
@end

@interface ProfitsRecordsEntity : NSObject

/*现价（对手 价）*/
@property (nonatomic,copy)NSString *cur_price;
/*盈亏(正盈负亏)*/
@property (nonatomic,copy)NSString *profit;
/*状态:-1状态查询;0;失败;1;正在申购;2：申购完成等待卖出（股票当日不可卖状态）;3;已开仓，可中止合作;4：系统接管订单（用户失去操作权）;5;触发锁定卖出中;7;市价锁定卖出中;9;触发锁定卖出;11;市价锁定卖出;13;回调止赢卖出;15;止损中止卖出;17;到时中止卖出;18;触发价申报中;19;结束未结算;20;结束已结算;21：开仓前已中止*/
@property (nonatomic,copy)NSString *state;
/*状态翻译文字*/
@property (nonatomic,copy)NSString *state_name;
/*昨收价*/
@property (nonatomic,copy)NSString *y_close;

@property (nonatomic,copy)NSString *buy_deal_price_avg;//	开仓价	float
@property (nonatomic,copy)NSString *sell_deal_price_avg;//	平仓价	float

@property (nonatomic,copy)NSString *profit_rate;//	盈亏率	float

@property (nonatomic,copy)NSString *key_id;

@property (nonatomic,copy)NSString *sell_start_price;


/*止盈价*/
@property (nonatomic,copy)NSString *sell_win_price;
/*止损价*/
@property (nonatomic,copy)NSString *sell_loss_price;
@end
