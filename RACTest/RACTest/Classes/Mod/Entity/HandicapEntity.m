//
//  HandicapEntity.m
//  RACTest
//
//  Created by  rjt on 17/5/25.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "HandicapEntity.h"

@implementation HandicapEntity
//接口返回百元为单位，实际显示万元为单位
-(NSString *)amount{
    NSInteger a =  [_amount floatValue]/100;
    return [NSString stringWithFormat:@"%ld",(long)a ];
}

@end
