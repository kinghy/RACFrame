//
//  SettlementsEntity.h
//  TPZ
//
//  Created by chenyi on 16/2/26.
//  Copyright © 2016年 JYZD. All rights reserved.
//

@class SettlementsRecordsEntity;

#define kSettleCreateCheck @"0"//账单生成中
#define kSettleDoPress @"1"//催款
#define kSettleDoPay @"2"//付款
#define kSettleDoSettling @"3"//付款
#define kSettleDoSettlingStr @"结算中"//付款

@interface SettlementsEntity : NSObject<IRFEntity>

@property (nonatomic,strong) NSArray<SettlementsRecordsEntity*> *records;

@end

@interface SettlementsRecordsEntity : NSObject

/*产品ID*/
@property (nonatomic,copy) NSString *ID;
/*产品类型*/
@property (nonatomic,copy) NSString *p_type;
/*产品id*/
@property (nonatomic,copy) NSString *p_id;
/*点买方向 1：多， 2：空,3:双向做多 4:双向做空*/
@property (nonatomic,copy) NSString *operation_direction;
/*产品子类型 0:非递延 n:T+Dn(9就是T+D9)*/
@property (nonatomic,copy) NSString *sub_type;
/*开户名*/
@property (nonatomic,copy) NSString *stocker_user_name;
/*状态 0：待清算 1：待收款 2：待付款 3：待结算 4：已结算*/
@property (nonatomic,copy) NSString *state;
/*状态翻译文字*/
@property (nonatomic,copy) NSString *state_name;
/*交易单号*/
@property (nonatomic,copy) NSString *pno;
/*发布时间*/
@property (nonatomic,copy) NSString *create_time;
/*开始时间*/
@property (nonatomic,copy) NSString *start_time;
/*产品代码*/
@property (nonatomic,copy) NSString *code;
/*品种名称*/
@property (nonatomic,copy) NSString *stock_name;
/*申购数量*/
@property (nonatomic,copy) NSString *amount;
/*点买金额*/
@property (nonatomic,copy) NSString *fund;
/*点买触发价*/
@property (nonatomic,copy) NSString *buy_start_price;
/*点买方式 0：市价点买 1：触发价点买*/
@property (nonatomic,copy) NSString *buy_way;
/*点卖触发价*/
@property (nonatomic,copy) NSString *sell_start_price;
/*点买方式 0：市价点卖 1：触发价点卖*/
@property (nonatomic,copy) NSString *sell_way;
/*盈利（执行结果*/
@property (nonatomic,copy) NSString *profit;
/*分配利润*/
@property (nonatomic,copy) NSString *user_profit;

/*止盈（盈利目标*/
@property (nonatomic,copy) NSString *stop_profit_point;

/*执行盈亏*/
@property (nonatomic,copy) NSString *stop_loss_point;
/*执行盈亏*/
@property (nonatomic,copy) NSString *uid;

/*方案名*/
@property (nonatomic,copy) NSString *scheme_name;
/*投资人Id*/
@property (nonatomic,copy) NSString *invester_id;

/*投资人账户*/
@property (nonatomic,copy) NSString *invest_account;

/*投资人名*/
@property (nonatomic,copy) NSString *invester_name;
/*交易市场*/
@property (nonatomic,copy) NSString *invest_dealer;

/*投资人开户营业部*/
@property (nonatomic,copy) NSString *invest_open_dealer;
/*投资人开户地*/
@property (nonatomic,copy) NSString *invest_location;

/*投资人头像地址*/
@property (nonatomic,copy) NSString *invest_icon;
/*投资人头像地址*/
@property (nonatomic,copy) NSString *dealer_replace;


@end
