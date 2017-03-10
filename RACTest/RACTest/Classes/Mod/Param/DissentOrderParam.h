//
//  DissentOrderMock.h
//  QianFangGuJie
//
//  Created by 财道 on 15/1/14.
//  Copyright (c) 2015年 余龙. All rights reserved.
//
//创建异议申报

@interface DissentOrderParam : AppParam
/**产品类型 Stock，au，ag，if*/
@property (nonatomic,copy) NSString *p_type;
@property(copy,nonatomic)NSString* p_id;     //产品id
/**异议点 1买入价 2卖出价 3盈亏分配 4交易数量 5亏损赔付 6履约金解冻 7其它 8 交易费用 9 止损 10 结算*/
@property(copy,nonatomic)NSString* point;     //异议点
@property(copy,nonatomic)NSString* price;   //异议价格
@property(copy,nonatomic)NSString* reason;  //理由
@end

