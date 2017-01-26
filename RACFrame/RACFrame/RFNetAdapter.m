//
//  RFNetAdapter.m
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFNetAdapter.h"
#import "RFNetWorking.h"
#import <objc/runtime.h>

@implementation RFNetAdapter
#pragma mark - init methods
+(instancetype)netAdapter{
    return [[self alloc] init];
}

-(instancetype)init{
    if(self = [super init]){
        _netWorking = [RFNetWorking netWorking];
    }
    return self;
}

#pragma mark - public methods
-(RACSignal *)connectWithUrl:(NSString *)url andMethod:(int)method andHeaders:(NSDictionary *)headers andParams:(NSDictionary *)params andTimeOut:(int)timeOut{
    RACSignal *netSignal;
    switch (method) {
        case kGetMethod:
            netSignal = [_netWorking getWithUrl:url andHeaders:headers andParams:params andTimeOut:timeOut];
            break;
        case kPostMethod:
            netSignal = [_netWorking postWithUrl:url andHeaders:headers andParams:params andTimeOut:timeOut];
        default:
            break;
    }
    return netSignal;
}

-(RACSignal *)onlineWithUrl:(NSString *)url andMethod:(int)method andHeaders:(NSDictionary *)headers andParams:(NSDictionary *)params andTimeOut:(int)timeOut isLazy:(BOOL)isLazy{
    RACSignal* signal = [self connectWithUrl:url andMethod:method andHeaders:headers andParams:params andTimeOut:timeOut];
    return isLazy?[signal replayLazily]:[signal replay];
}

-(RACSignal *)fetchWithParam:(id<RFParamInt>)param{
    int timeout = [param respondsToSelector:@selector(getTimeOut)]?[param getTimeOut]:kRFNetTimeOut;
    BOOL isOnline = [param respondsToSelector:@selector(isOnline)]?[param isOnline]:NO;
    BOOL isLazy = [param respondsToSelector:@selector(isLazy)]?[param isLazy]:NO;
    Class entityClss = [param respondsToSelector:@selector(getEntityClass)]?[param getEntityClass]:nil;
    NSDictionary* headers = [param respondsToSelector:@selector(getHeaders)]?[param getHeaders]:nil;
    NSDictionary* p = [self getDictFromParam:param class:[param class]];
    NSString *url = [param getUrl];
    int method = [param respondsToSelector:@selector(getMethod)]?[param getMethod]:kGetMethod;
    RACSignal *retSignal = nil;
    if(isOnline){
        retSignal = [self onlineWithUrl:url andMethod:method andHeaders:headers andParams:p andTimeOut:timeout isLazy:isLazy];
    }else{
        retSignal = [self connectWithUrl:url andMethod:method andHeaders:headers andParams:p andTimeOut:timeout];
    }
    
    return [retSignal map:^id(id value) {
        NSObject* o = [entityClss new];
        if(entityClss){
            [self getEntityFromJson:value entity:&o class:entityClss];
        }else{
            o = value;
        }
        return o;
    }];
}

#pragma mark - private methods
-(NSDictionary*)getDictFromParam:(NSObject *)param class:(Class)cls{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if(cls != [NSObject class]){
        //定义类属性的数量
        unsigned propertyCount;
        //获取对象的全部属性并循环显示属性名称和属性特性参数
        objc_property_t *properties = class_copyPropertyList(cls,&propertyCount);
        for(int i=0;i<propertyCount;i++){
            objc_property_t prop=properties[i];
            NSString * name = [NSString stringWithFormat:@"%s",property_getName(prop)];
            @try {
                [dict setObject:[param valueForKey:name] forKey:name ];
            }
            @catch (NSException *exception) {
                
            }
            @finally{
                //                free(prop);
            }
        }
        free(properties);
        
        //迭代反射父类方法
        [dict addEntriesFromDictionary:[self getDictFromParam:param class:[cls superclass]]];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

-(void)getEntityFromJson:(id)json entity:(NSObject**)entity class:(Class)cls{
    NSObject * ent = *entity;
    if ([ent isKindOfClass:cls]) {
        if (cls != [NSObject class]) {
            if([json isKindOfClass:[NSDictionary class]]){
                //定义类属性的数量
                unsigned propertyCount;
                //获取对象的全部属性并循环显示属性名称和属性特性参数
                objc_property_t *properties = class_copyPropertyList(cls,&propertyCount);
                for(int i=0;i<propertyCount;i++){
                    objc_property_t prop=properties[i];
                    NSString * name = [NSString stringWithFormat:@"%s",property_getName(prop)];
                    NSString * jsonName = name;
                    if ([name isEqualToString:@"ID"]) {
                        jsonName = @"id";
                    }
                    @try {
                        if ([[json objectForKey:jsonName] isKindOfClass:[NSArray class]]) {
                            Class pkClass = nil;
                            if([ent conformsToProtocol:@protocol(RFEntityInt)] && [ent respondsToSelector:@selector(getEntityClssByKey:)]){
                                pkClass = [(id<RFEntityInt>)ent getEntityClssByKey:jsonName];
                            }
                            if (pkClass) {
                                NSMutableArray *array = [NSMutableArray array];
                                
                                NSArray *tmpArray = [json objectForKey:jsonName];
                                for (id tmp in tmpArray) {
                                    id ent = [[pkClass alloc] init];
                                    if ([ent isKindOfClass:[NSObject class]]) {
                                        id tmpJson = tmp;
                                        if ([ent conformsToProtocol:@protocol(RFEntityInt)] && [ent respondsToSelector:@selector(parseJson:byKey:)]) {
                                            tmpJson = [ent parseJson:tmp byKey:jsonName];
                                        }
                                        [self getEntityFromJson:tmpJson entity:&ent class:pkClass];
                                        [array addObject:ent];
                                    }else{
                                        [array addObject:tmp];
                                    }
                                    
                                }
                                [ent setValue:array forKey:name];
                            }else{
                                [ent setValue:[json objectForKey:jsonName] forKey:name];
                            }
                        }else if([[json objectForKey:jsonName] isKindOfClass:[NSDictionary class]]){
                            Class pkClass = nil;
                            if([ent conformsToProtocol:@protocol(RFEntityInt)] && [ent respondsToSelector:@selector(getEntityClssByKey:)]){
                                pkClass = [(id<RFEntityInt>)ent getEntityClssByKey:jsonName];
                            }
                            if (pkClass) {
                                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                                
                                NSDictionary *tmpDict = [json objectForKey:jsonName];
                                for (NSString* key in [tmpDict allKeys]) {
                                    id ent = [[pkClass alloc] init];
                                    id tmp = [tmpDict objectForKey:key];
                                    if ([ent isKindOfClass:[NSObject class]]) {
                                        id tmpJson = tmp;
                                        if ([ent conformsToProtocol:@protocol(RFEntityInt)] && [ent respondsToSelector:@selector(parseJson:byKey:)]) {
                                            tmpJson = [ent parseJson:tmp byKey:jsonName];
                                        }
                                        [self getEntityFromJson:tmpJson entity:&ent class:pkClass];
                                        [dict setObject:entl forKey:key];
                                    }else{
                                        [dict setObject:tmp forKey:key];
                                    }
                                    
                                }
                                [ent setValue:dict forKey:name];
                            }else{
                                [ent setValue:[json objectForKey:jsonName] forKey:name];
                            }
                        }else{
                            if ([json objectForKey:jsonName]) {
                                
                                NSString *tmp = [NSString stringWithFormat:@"%s",property_getAttributes(prop) ];
                                NSRange range = [tmp rangeOfString:@"NSString"];
                                if (range.location != NSIntegerMax) {
                                    [ent setValue:[NSString stringWithFormat:@"%@",[json objectForKey:jsonName]] forKey:name];
                                }else{
                                    [ent setValue:[json objectForKey:jsonName] forKey:name];
                                }
                                
                            }
                            
                        }
                    }
                    @catch (NSException *exception) {
                    }
                    @finally{
                        //                        free(prop);
                    }
                    
                }
                free(properties);
                //迭代反射父类方法
                [self getEntityFromJson:json entity:&ent class:[cls superclass] aliasName:aliasName];
            }
        }
    }
}

#pragma mark - 使字符串首字母变成大写
-(NSString*)makeFirstCharUppercase:(NSString*)str{
    if (str.length > 0) {
        NSString *firstChar = [str substringWithRange:NSMakeRange(0, 1)];
        [firstChar uppercaseString];
        return  [NSString stringWithFormat:@"%@%@",[firstChar uppercaseString],[str substringWithRange:NSMakeRange(1, str.length - 1)]] ;
    }
    return str;
}


@end
