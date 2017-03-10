//
//  AppUtil.m
//  QianFangGuJie
//  此类中实现一些工具方法
//  Created by  rjt on 15/9/14.
//  Copyright © 2015年 JYZD. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil

+(UIColor*)colorWithOpen:(float)open andNew:(float)now{
    if (open > now && now > 0) {
        return kDownGreenColor;
    }else if(now > open ){
        return kUpRedColor;
    }else{
        return kFlatGrayColor;
    }
}

+(UIColor*)colorWithProfit:(float)profit{
    if (profit < 0) {
        return kDownGreenColor;
    }else{
        return kUpRedColor;
    }
}

+(NSString *)moneyStringFormat:(NSString*)money{
    return [AppUtil moneyFloatFormat:[money floatValue]];
}

+(NSString *)moneyFloatFormat:(float)money{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setPositiveFormat:@",###.00;"];
    return money==0?@"0.00":[formatter stringFromNumber:[NSNumber numberWithFloat:money]];
}

@end
