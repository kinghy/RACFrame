//
//  MyAllListEntity.h
//  STO
//
//  Created by chenyi on 16/6/27.
//  Copyright © 2016年 JYZD. All rights reserved.
//

@interface MyAllListEntity : NSObject<IRFEntity>

@property(nonatomic,strong)NSArray *records;
@end

@interface MyAllListRecordsEntity : NSObject<IRFEntity>

@property(nonatomic,strong)NSString *	ID	;	//	产品ID	Int
@property(nonatomic,strong)NSString *	p_type	;	//	产品类型	string
@property(nonatomic,strong)NSString *	pno	;	//	交易单号	string
@property(nonatomic,strong)NSString *	operation_direction	;	//	点买方向 1:多 2:空 3:双向多 4:双向空	Int
@property(nonatomic,strong)NSString *	start_time	;	//	开始时间	Int
@property(nonatomic,strong)NSString *	Init_fund	;	//	实际申购金额	float
@property(nonatomic,strong)NSString *	amount	;	//	申购数量	Int
@property(nonatomic,strong)NSString *	code	;	//	产品代码	String
@property(nonatomic,strong)NSString *	fund	;	//	点买金额	float
@property(nonatomic,strong)NSString *	start_price	;	//	触发价	float
@property(nonatomic,strong)NSString *	buy_way	;	//	购买方式	Int 0:市价点买 1:触发价点买
@property(nonatomic,strong)NSString *	state	;	//	状态	String
@property(nonatomic,strong)NSString *	stock_name	;	//	产品名称	String
@property(nonatomic,strong)NSString *	state_name	;	//	状态翻译文字	String
@property(nonatomic,strong)NSString *	invester_id	;	//	投资人Id	Int
@property(nonatomic,strong)NSString *	invest_account	;	//	投资人账户	string
@property(nonatomic,strong)NSString *	invester_name	;	//	投资人名	string
@property(nonatomic,strong)NSString *	invest_dealer	;	//	交易市场	string
@property(nonatomic,strong)NSString *	invest_open_dealer	;	//	投资人开户营业部	string
@property(nonatomic,strong)NSString *	invest_location	;	//	投资人开户地	string
@property(nonatomic,strong)NSString *	invest_icon	;	//	投资人头像地址	string
@property(nonatomic,strong)NSString *	user_profit	;	//	分配利润	float
@property(nonatomic,strong)NSString *	tips1	;	//	翻译文字1	string
@property(nonatomic,strong)NSString *	tips2	;	//	翻译文字2	string
@property(nonatomic,strong)NSString *	tipscolor	;	//	翻译文字2的颜色 1：红 2：灰 3：黑	string

@property(nonatomic,strong)NSString *	sub_type	;


@end
