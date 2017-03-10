//
//  OrderdetailsEntity.h
//  STO
//
//  Created by admin on 2017/1/6.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#define kSettleCreateCheck @"0"//账单生成中
#define kSettleDoPress @"1"//催款
#define kSettleDoPay @"2"//付款
#define kSettleDoSettling @"3"//付款
#define kSettleDoSettlingStr @"结算中"//付款

@interface OrderDetailsEntity : NSObject

/*产品ID*/
@property (nonatomic,copy) NSString *ID;
/*产品ID*/
@property (nonatomic,copy) NSString *p_id;
/*点买人id*/
@property (nonatomic,copy) NSString *uid;
/*投资人Id*/
@property (nonatomic,copy) NSString *invester_id;
/*投资人名*/
@property (nonatomic,copy) NSString *invester_name;
@property (nonatomic,copy) NSString *invest_dealer;//	交易市场	string
@property (nonatomic,copy) NSString *invest_open_dealer;//	开户营业部	string
@property (nonatomic,copy) NSString *invest_location;//	开户地	string
@property (nonatomic,copy) NSString *invest_account;//	资金账号	string
@property (nonatomic,copy) NSString *holder_account;//	股东账号	string
/*保证金*/
@property (nonatomic,copy) NSString *bid_bond;
/*发布时间*/
@property (nonatomic,copy) NSString *create_time;
/*合作时间*/
@property (nonatomic,copy) NSString *start_time;
/*结束时间*/
@property (nonatomic,copy) NSString *end_time;
/*操作方向 1：多 2：空*/
@property (nonatomic,copy) NSString *operation_direction;
/*状态*/
@property (nonatomic,copy) NSString *state;
/*状态翻译*/
@property (nonatomic,copy) NSString *state_name;
/*交易单号*/
@property (nonatomic,copy) NSString *pno;
/*产品代码*/
@property (nonatomic,copy) NSString *code;
/*买数量*/
@property (nonatomic,copy) NSString *amount;
/*金额*/
@property (nonatomic,copy) NSString *fund;
/*买入均价（开仓价）*/
@property (nonatomic,copy) NSString *buy_deal_price_avg;
/*卖出均价（平仓价）*/
@property (nonatomic,copy) NSString *sell_deal_price_avg;
/*开仓触发价*/
@property (nonatomic,copy) NSString *start_price;
/*平仓触发价*/
@property (nonatomic,copy) NSString *sell_start_price;
/*开仓成交时间*/
@property (nonatomic,copy) NSString *buy_deal_time;
/*平仓成交时间*/
@property (nonatomic,copy) NSString *sell_deal_time;
/*点买方式 0:市价点买 1：触发价点买*/
@property (nonatomic,copy) NSString *buy_way;
/*点卖方式 0:市价点卖 1：触发价点卖*/
@property (nonatomic,copy) NSString *sell_way;
/*盈利*/
@property (nonatomic,copy) NSString *profit;
/*分配利润 >0时填盈利分配 <0时填亏损赔付*/
@property (nonatomic,copy) NSString *user_profit;
/*清算标志 1 已结算*/
@property (nonatomic,copy) NSString *settlemnt_flag;
/*扣减保证金*/
@property (nonatomic,copy) NSString *bid_bond_minus;
/*预计讨讫（结算）时间*/
@property (nonatomic,copy) NSString *settlement_deadline;
/*点买人昵称*/
@property (nonatomic,copy) NSString *nickname;
/*投资人昵称*/
@property (nonatomic,copy) NSString *invester_nickname;
/*产品名称*/
@property (nonatomic,copy) NSString *stock_name;
/*结算类型 1市价卖出 2止盈中止 3止损中止 4尾盘到时中止 5到时中止 6触发价挂单超时（买入时）*/
@property (nonatomic,copy) NSString *clear_type;
/*信用还款*/
@property (nonatomic,copy) NSString *credit_repayment;
/*买入类型翻译文字*/
@property (nonatomic,copy) NSString *buy_type;
/*卖出类型翻译文字*/
@property (nonatomic,copy) NSString *sell_type;
/*点买手续费*/
@property (nonatomic,copy) NSString *fee_total;
/*方案名*/
@property (nonatomic,copy) NSString *scheme_name;
/*赢利分配方案*/
@property (nonatomic,copy) NSDictionary *distribution;
/*用户分配比例*/
@property (nonatomic,copy) NSString *user_profit_rate;
/*最大亏损赔付*/
@property (nonatomic,copy) NSString *stop_loss_point;
@property (nonatomic,copy) NSString *stop_profit_point;//	盈利目标	float
@property (nonatomic,copy) NSString *end_flag;//	协商中止:1:允许 0：不允许	string
/*开仓策略执行时间*/
@property (nonatomic,copy) NSString *buy_execute_time;
/*平仓策略执行时间*/
@property (nonatomic,copy) NSString *sell_execute_time;/*平仓策略执行时间*/
/*异议标志:0:不能提交异议 1:可以提交异议 2：有异议处理中*/
@property (nonatomic,copy) NSString *dissent_flag;
/*交易费用*/
@property (nonatomic,copy)NSString *info_fee;

@property (nonatomic,copy)NSString *max_user_loss;

@property (nonatomic,copy)NSString *p_type;
/*违约标志:0:非违约 1:违约*/
@property (nonatomic,copy)NSString *compensate_flag;
/*盈利目标类型 0:百分比 1:元每股*/
@property (nonatomic,copy)NSString *stop_profit_point_flag;

@property (nonatomic, copy)NSString *dealer_replace;

@property (nonatomic, copy) NSString *buy_fund;

@property (nonatomic, copy) NSString *sell_fund;

@property (nonatomic, copy) NSString *buy_amount;

@property (nonatomic, copy) NSString *sell_amount;

@property (nonatomic, copy) NSString *sub_type;

@property (nonatomic, copy) NSString *buy_amount_float;

@property (nonatomic, copy) NSString *sell_amount_float;


@end




