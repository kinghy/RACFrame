//
//  RFNetWorking.h
//  RACFrame
//
//  Created by  rjt on 17/1/11.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSInteger, RFNetWorkingRespSerializer) {
    RFNetWorkingRespSerializerJSON,
    RFNetWorkingRespSerializerImage,
};
typedef NS_ENUM(NSInteger, RFNetWorkingMethod) {
    RFNetWorkingMethodGet,
    RFNetWorkingMethodPost,
};

@interface RFNetWorking : NSObject

/**
 以POST/GET方式进行网络请求，如果请求正常则sendNext,如果异常则sendError，但是当isSilence为true时将异常信息正常sendNext需要由用户自行处理
 @param url 接口地址
 @param method 访问方式,kGetMethod/kPostMethod
 @param headers 头部信息
 @param params 参数
 @param timeOut 超时
 @param serializer 返回值格式化类型，RFNetWorkingRespSerializer
 @param ignoreError 是否忽略网络错误
 @return RFNetWorking实例
 */
+(instancetype)netWorkingWithUrl:(NSString*)url andMethod:(RFNetWorkingMethod)method andHeaders:(NSDictionary*)headers andParams:(NSDictionary*)params andTimeOut:(int)timeOut andRespSerializer:(RFNetWorkingRespSerializer)serializer ignoreError:(BOOL)ignoreError;

/**
 以POST/GET方式进行网络请求，如果请求正常则sendNext,如果异常则sendError，但是当isSilence为true时将异常信息正常sendNext需要由用户自行处理
 @param url 接口地址
 @param method 访问方式,RFNetWorkingMethod
 @param headers 头部信息
 @param params 参数
 @param timeOut 超时
 @param serializer 返回值格式化类型，RFNetWorkingRespSerializer
 @param ignoreError 是否忽略网络错误
 @return RFNetWorking实例
 */
-(instancetype)initWithUrl:(NSString*)url andMethod:(RFNetWorkingMethod)method andHeaders:(NSDictionary*)headers andParams:(NSDictionary*)params andTimeOut:(int)timeOut andRespSerializer:(RFNetWorkingRespSerializer)serializer ignoreError:(BOOL)ignoreError;

@property (weak,nonatomic,readonly) RACSignal *signal;
@end
