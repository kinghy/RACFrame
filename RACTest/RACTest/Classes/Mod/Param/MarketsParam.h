//
//  MarketsParam.h
//  RACTest
//
//  Created by  rjt on 17/5/26.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppParam.h"

@interface MarketsParam : AppParam
/**产品代码*/
@property (nonatomic,copy) NSString *opt;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *excode;
@property (nonatomic,copy) NSString *type;
@end
