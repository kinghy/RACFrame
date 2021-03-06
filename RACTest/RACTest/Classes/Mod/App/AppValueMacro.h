//
//  AppValueMacro.h
//  RACTest
//
//  Created by  rjt on 17/2/15.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#ifndef AppValueMacro_h
#define AppValueMacro_h

#define kMarketDomian @"http://192.168.6.66:2050"
#define kUserDomian @"http://192.168.6.113:8115"
#define kProductDomian @"http://192.168.6.113:8116"

#define kCurrentDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kCurrentDeciceHeight [UIScreen mainScreen].bounds.size.height

#define VERSION  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
#define kAppName  [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]
#define kAppDisplayName  [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)CFBundleDisplayName]

#define kArrayLimit @"15";
#endif /* AppValueMacro_h */

#define kGlobalLoginExpired @"kGlobalLoginExpired"
#define kGlobalLogin @"kGlobalLogin"

#define kDissentPointInfoStr @"信息服务费"
#define kDissentPointInfoKey @"8"
#define kDissentPointBuyStr @"买入均价"
#define kDissentPointBuyKey @"1"
#define kDissentPointSellStr @"卖出均价"
#define kDissentPointSellKey @"2"
#define kDissentPointProfitStr @"盈亏分配"
#define kDissentPointProfitKey @"-1"
#define kDissentPointCheckStr @"结算"
#define kDissentPointCheckKey @"10"
#define kDissentPointOtherStr @"其他"
#define kDissentPointOtherKey @"7"
#define kDissentPointWinStr @"盈利分配"
#define kDissentPointWinKey @"3"
#define kDissentPointLossStr @"亏损赔付"
#define kDissentPointLossKey @"5"

#define kMyStrategyAll @"1"//所有我的策略
#define kMyStrategyToday @"2"//今日创建
#define kMyStrategyLast @"3"//最后持仓日
#define kMyStrategyNotLast @"4"//非最后持仓日
#define kMyStrategySell @"5"//已平仓

#define kListLimit @"10"

#define kStoCodeSH @"sh.999999"
#define kStoNameSH @"上证指数"

#define kStoCodeSZ @"399001"
#define kStoNameSZ @"深证成指"

#define kStoCodeCreate @"399006"
#define kStoNameCreate @"创业板指"

#define kStoCode300 @"399300"
#define kStoName300 @"沪深300"

