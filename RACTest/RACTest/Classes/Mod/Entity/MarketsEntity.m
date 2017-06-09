//
//  MarketsEntity.m
//  RACTest
//
//  Created by  rjt on 17/5/26.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "MarketsEntity.h"

@implementation MarketsEntity
-(Class)getEntityClssByKey:(NSString*)key{
    if([key isEqualToString:@"records"]){
        return [MarketsRecordsEntity class];
    }
    return nil;
}
@end

@implementation MarketsRecordsEntity

-(void)setStockcode:(NSString *)stockcode{
    if (stockcode && [stockcode isEqualToString:@"999999"]) {
        stockcode = kStoCodeSH;
    }
    _stockcode = stockcode;
}

@end
