//
//  RFNetAdapter.h
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFNetWorking.h"

#define kRFNetTimeOut 15;

@class RFNetWorking;

@protocol IRFParam <NSObject>

@required
/**
 返回网络地址
 
 @return 返回域名
 */
-(NSString*)getDomain;

/**
 返回网络地址

 @return 返回路径
 */
-(NSString*)getPath;

@optional

/**
 返回访问方式kPostMetcod/kGetMethod,如果不实现默认使用kGetMethod访问

 @return 返回访问方式
 */
-(RFNetWorkingMethod)getMethod;

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
 返回用来格式化Response值的类型,如果不实现将使用RFNetWorkingRespSerializerJSON格式化Response值
 
 @return 返回RFNetWorkingRespSerializer
 */
-(RFNetWorkingRespSerializer)getResponseMode;

/**
 返回是否需直播信号(热信号)，，如果不实现默认为NO（冷信号）
 
 @return 返回是否需要懒加载
 */
-(BOOL)isOnline;


/**
 返回是否需要保持静默，当发生网络错误时不像您发送错误信息,默认值为NO
 
 @return 返回是否需要保持静默
 */
-(BOOL)isSilence;


/**
 返回请求结果是否有效，如果无效sendError、如果选择静默则直接sendComplete

 @param result 请求结果
 @param error 输出错误信息
 @return 返回请求结果是否有效
 */
-(BOOL)isResultValid:(id)result error:(NSError**)error;


@end

@protocol IRFEntity <NSObject>

@optional
-(Class)getEntityClssByKey:(NSString*)key;

-(id)parseJson:(id)dict byKey:(NSString*)key;

@end


@interface RFNetAdapter : NSObject{
    RFNetWorking *_netWorking;
    RACSignal *_signal;
    long _count;
}

/**
 使用实现IRFParam协议的对象来访问网络

 @param param 实现IRFParam协议的对象
 @return 返回一个RFNetAdapter实例
 */
+(instancetype)netAdapterWithParam:(id<IRFParam>)param;

/**
 使用实现IRFParam协议的对象来访问网络
 
 @param param 实现IRFParam协议的对象
 @return 返回一个RFNetAdapter实例
 */
-(instancetype)initWithParam:(id<IRFParam>)param;

@property (strong,nonatomic,readonly) RACSignal *signal;

//工具方法，便于测试，无须直接调用
-(NSDictionary*)getDictFromParam:(NSObject *)param class:(Class)cls;
//工具方法，便于测试，无须直接调用
-(void)getEntityFromJson:(id)json entity:(NSObject**)entity class:(Class)cls;
@end
