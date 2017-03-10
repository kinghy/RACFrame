//
//  DissentOrderEntity.h
//  QianFangGuJie
//
//  Created by 李荣 on 15/1/14.
//  Copyright (c) 2015年 余龙. All rights reserved.
//
//创建异议申报

@interface DissentOrderEntity : NSObject
@property(strong,nonatomic)NSString* result;    //结果
/**30119:错误的异议申报的时间
 30120:错误的异议申报的时间
 30121:超过该订单异议申报次数
 30122（暂定）:存在正在申报的异议*/
@property(copy,nonatomic)NSString* code;       //错误码
@property(strong,nonatomic)NSString* error_msg;    //错误信息
@end
