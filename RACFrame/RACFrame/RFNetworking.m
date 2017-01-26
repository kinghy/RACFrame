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

+(instancetype)netWorking{
    return [[self alloc] init];
}

-(RACSignal *)postWithUrl:(NSString*)url andHeaders:(NSDictionary *)headers andParams:(NSDictionary *)params andTimeOut:(int)timeOut{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        AFHTTPSessionManager *manager = [self createManagerWithHeaders:headers andTimeoOut:timeOut];
        NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//对中文进行编码
        NSDictionary* tmpdict = [self filteParams:params];

        [manager POST:strUrl parameters:tmpdict progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

-(RACSignal *)getWithUrl:(NSString*)url andHeaders:(NSDictionary *)headers andParams:(NSDictionary *)params andTimeOut:(int)timeOut{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        AFHTTPSessionManager *manager = [self createManagerWithHeaders:headers andTimeoOut:timeOut];
        NSString *strUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//对中文进行编码
        NSDictionary* tmpdict = [self filteParams:params];
        
        [manager GET:strUrl parameters:tmpdict progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        return nil;
    }];
}

-(AFHTTPSessionManager*)createManagerWithHeaders:(NSDictionary *)headers andTimeoOut:(int)timeOut{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = timeOut;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
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

@end
