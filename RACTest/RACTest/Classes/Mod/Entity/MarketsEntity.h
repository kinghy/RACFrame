//
//  MarketsEntity.h
//  RACTest
//
//  Created by  rjt on 17/5/26.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MarketsRecordsEntity;

@interface MarketsEntity : NSObject<IRFEntity>
@property (nonatomic,strong) NSArray<MarketsRecordsEntity*> *records;
@end

@interface MarketsRecordsEntity : NSObject
/**产品代码*/
@property (nonatomic,copy) NSString *stockcode;
/**产品名称*/
@property (nonatomic,copy) NSString *stockname;
/**产品价格*/
@property (nonatomic,copy) NSString *New;
/**昨日收盘价*/
@property (nonatomic,copy)NSString *YClose;

@property (nonatomic,copy)NSString *Buy1;

@property (nonatomic,copy) NSString *Sell1;
@end
