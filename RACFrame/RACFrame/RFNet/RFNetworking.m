//
//  RFNetWorking.m
//  RACFrame
//
//  Created by  rjt on 17/1/11.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFNetWorking.h"
#import <AFNetworking/AFNetworking.h>


@implementation RFNetWorking

+(instancetype)netWorkingWithUrl:(NSString*)url andMethod:(RFNetWorkingMethod)method andHeaders:(NSDictionary*)headers andParams:(NSDictionary*)params andTimeOut:(int)timeOut andRespSerializer:(RFNetWorkingRespSerializer)serializer ignoreError:(BOOL)ignoreError{
    
    return [[RFNetWorking alloc] initWithUrl:url andMethod:method andHeaders:headers andParams:params andTimeOut:timeOut andRespSerializer:serializer ignoreError:ignoreError];
}

-(instancetype)initWithUrl:(NSString *)url andMethod:(RFNetWorkingMethod)method andHeaders:(NSDictionary *)headers andParams:(NSDictionary *)params andTimeOut:(int)timeOut andRespSerializer:(RFNetWorkingRespSerializer)serializer ignoreError:(BOOL)ignoreError{
    if(self=[super init]){
        _count = 0;
        switch (method) {
            case RFNetWorkingMethodPost:
                _signal = [self postWithUrl:url andHeaders:headers andParams:params andTimeOut:timeOut  andRespSerializer:serializer ignoreError:ignoreError ];
                break;
            case RFNetWorkingMethodGet:
                _signal = [self getWithUrl:url andHeaders:headers andParams:params andTimeOut:timeOut  andRespSerializer:serializer ignoreError:ignoreError];
                break;
            default:
                break;
        }

    }
    return self;
}


-(RACSignal *)postWithUrl:(NSString*)url andHeaders:(NSDictionary *)headers andParams:(NSDictionary *)params andTimeOut:(int)timeOut  andRespSerializer:(RFNetWorkingRespSerializer)serializer ignoreError:(BOOL)ignoreError{
//    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        @strongify(self);
        AFHTTPSessionManager *manager = [self createManagerWithHeaders:headers andTimeOut:timeOut andRespSerializer:serializer];
        NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//对中文进行编码
        NSDictionary* tmpdict = [self filteParams:params];
        
        [manager POST:strUrl parameters:tmpdict progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(ignoreError){
                [subscriber sendNext:error];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:error];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            //            @strongify(_holdSignal);
            NSLog(@"%ld",_count);
            if(--_count == 0){
                _signal = nil;
            }
        }];
    }];
;
}

-(RACSignal *)getWithUrl:(NSString*)url andHeaders:(NSDictionary *)headers andParams:(NSDictionary *)params andTimeOut:(int)timeOut  andRespSerializer:(RFNetWorkingRespSerializer)serializer ignoreError:(BOOL)ignoreError{
//    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //        @strongify(self);
        AFHTTPSessionManager *manager = [self createManagerWithHeaders:headers andTimeOut:timeOut andRespSerializer:serializer];
        NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//对中文进行编码
        NSDictionary* tmpdict = [self filteParams:params];
        [manager GET:strUrl parameters:tmpdict progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(ignoreError){
                [subscriber sendNext:error];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:error];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            //            @strongify(_holdSignal);
            if(--_count == 0){
                _signal = nil;
            }
        }];
    }];
}


-(AFHTTPSessionManager*)createManagerWithHeaders:(NSDictionary *)headers andTimeOut:(int)timeOut andRespSerializer:(RFNetWorkingRespSerializer)serializer{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = timeOut;
    switch (serializer) {
        case RFNetWorkingRespSerializerJSON:
//            manager.responseSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
            break;
        case RFNetWorkingRespSerializerImage:
            manager.responseSerializer = [AFImageResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    
    for(RACTuple *t in headers.rac_sequence.array){
        RACTupleUnpack(NSString *key,NSString *value) = t;
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    return  manager;
}

-(NSDictionary*)filteParams:(NSDictionary*)params{
    //讲大写ID转换为小写id
    NSMutableDictionary *tmpdict = [NSMutableDictionary dictionaryWithDictionary:params];
    if ([tmpdict objectForKey:@"ID"]) {
        [tmpdict setObject:[tmpdict objectForKey:@"ID"] forKey:@"id"];
        [tmpdict removeObjectForKey:@"ID"];
    }
    return tmpdict;
}

-(RACSignal *)signal{
    _count++;
    return _signal;
}

-(void)dealloc{
    NSLog(@"-------RFNetWorking has dealloced----------");
}

@end
