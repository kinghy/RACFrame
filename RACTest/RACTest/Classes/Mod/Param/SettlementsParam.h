//
//  SettlementsMock.h
//  TPZ
//
//  Created by chenyi on 16/2/26.
//  Copyright © 2016年 JYZD. All rights reserved.
//
@interface SettlementsParam : AppParam

/*点买时间 ＞= 该时间*/
@property (nonatomic,copy) NSString *from_time;
/*点买时间 ＜= 该时间*/
@property (nonatomic,copy) NSString *to_time;
/*取出记录数*/
@property (nonatomic,copy) NSString *limit;
/*从第几条记录开始取*/
@property (nonatomic,copy) NSString *offset;
/*增量开始id 0时取最新记录，默认为0. 正数时，获取id小于该参数绝对值的记录 负数时，获取id大于该参数绝对值的记录*/
@property (nonatomic,copy) NSString *start_id;

@end

