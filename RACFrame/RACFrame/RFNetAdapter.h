//
//  RFNetAdapter.h
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRFNetTimeOut 15;

@class RFNetWorking;

@protocol RFParamInt <NSObject>


/**
 返回网络地址

 @return 返回网络地址
 */
-(NSString*)getUrl;

@optional

/**
 返回访问方式kPostMetcod/kGetMethod,如果不实现默认使用kGetMethod访问

 @return 返回访问方式
 */
-(int)getMethod;

/**
 返回访问超时时间秒数,如果不实现默认超时时间kRFNetTimeOut

 @return 返回访问超时时间秒数
 */
-(int)getTimeOut;

/**
 返回头部参数字段
 
 @return 返回头部参数字段
 */
-(NSDictionary*)getHeaders;

/**
 返回用来格式化的Entity类,如果不实现请求返回值将被格式化成NSDictionary
 
 @return 返回用来格式化的Entity类
 */
-(Class)getEntityClass;

/**
 返回是否需直播信号(热信号)，，如果不实现默认为NO（冷信号）
 
 @return 返回是否需要懒加载
 */
-(BOOL)isOnline;


/**
 返回是否需要懒加载，仅当isOnline为YES时有效，如果不实现默认为YES

 @return 返回是否需要懒加载
 */
-(BOOL)isLazy;

@end

@protocol RFEntityInt <NSObject>

@optional
-(Class)getEntityClssByKey:(NSString*)key;

-(NSDictionary*)parseJson:(NSDictionary*)dict byKey:(NSString*)key;

@end


@interface RFNetAdapter : NSObject{
    RFNetWorking *_netWorking;
}

+(instancetype)netAdapter;

/**
 网络访问

 @param url 接口地址
 @param method 访问方式kPostMetcod/kGetMethod
 @param headers 接口header参数
 @param params 接口参数
 @param timeOut 超时
 @return 返回一个网络访问信号，
 */
-(RACSignal*)connectWithUrl:(NSString*)url andMethod:(int)method andHeaders:(NSDictionary*)headers andParams:(NSDictionary*)params andTimeOut:(int)timeOut;
/**
 直播网络访问
 @param url 接口地址
 @param method 访问方式kPostMetcod/kGetMethod
 @param headers 接口header参数
 @param params 接口参数
 @param timeOut 超时
 @param isLazy 是否懒信号
 @return 返回一个网络访问热信号
 */
-(RACSignal*)onlineWithUrl:(NSString*)url andMethod:(int)method andHeaders:(NSDictionary*)headers andParams:(NSDictionary*)params andTimeOut:(int)timeOut isLazy:(BOOL)isLazy;



/**
 使用实现RFParamInt协议的对象来访问网络

 @param param 实现RFParamInt协议的对象
 @return 返回一个网络访问信号
 */
-(RACSignal*)fetchWithParam:(id<RFParamInt>)param;

@end
