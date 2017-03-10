//
//  AppUtil.h
//  QianFangGuJie
//
//  Created by  rjt on 15/9/14.
//  Copyright © 2015年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IndexViewController.h"

@interface AppUtil : NSObject
+(UIColor*)colorWithOpen:(float)open andNew:(float)now;//根据价格差返回颜色

+(UIColor*)colorWithProfit:(float)profit;

+(NSString *)moneyStringFormat:(NSString*)money;
+(NSString *)moneyFloatFormat:(float)money;

@end
