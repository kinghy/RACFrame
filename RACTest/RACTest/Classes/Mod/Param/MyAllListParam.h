//
//  MyAllListParam.h
//  STO
//
//  Created by chenyi on 16/6/27.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "AppParam.h"

@interface MyAllListParam : AppParam

/*查询类型 1 所有 2 今日创建 3 最后持仓日 4非最后持仓日 5已平仓*/
@property(nonatomic,copy)NSString *type;
/*取出记录数*/
@property(nonatomic,copy)NSString *limit;
/*从第几条记录开始取*/
@property(nonatomic,copy)NSString *offset;
/*增量开始id 0时取最新记录，默认为0. 正数时，获取id小于该参数绝对值的记录 负数时，获取id大于该参数绝对值的记录*/
@property(nonatomic,copy)NSString *start_id;

@end
