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
+(instancetype)netAdapterWithParam:(id<IRFParam>)param{
    return [[self alloc] initWithParam:param];
}

-(instancetype)initWithParam:(id<IRFParam>)param{
    if(self = [super init]){
        _count = 0;
        _signal = [self fetchWithParam:param];
    }
    return self;
}

#pragma mark - public methods

-(RACSignal *)fetchWithParam:(id<IRFParam>)param{
    int timeout = [param respondsToSelector:@selector(getTimeOut)]?[param getTimeOut]:kRFNetTimeOut;
    BOOL isOnline = [param respondsToSelector:@selector(isOnline)]?[param isOnline]:NO;
    BOOL isSilence = [param respondsToSelector:@selector(isSilence)]?[param isSilence]:NO;
    Class entityClss = [param respondsToSelector:@selector(getEntityClass)]?[param getEntityClass]:nil;
    NSDictionary* headers = [param respondsToSelector:@selector(getHeaders)]?[param getHeaders]:nil;
    NSDictionary* p = [self getDictFromParam:param class:[param class]];
    NSString *url = [NSString stringWithFormat:@"%@%@",[param getDomain],[param getPath]];
    int method = [param respondsToSelector:@selector(getMethod)]?[param getMethod]:RFNetWorkingMethodGet;
    RFNetWorkingRespSerializer mode = [param respondsToSelector:@selector(getResponseMode)]?[param getResponseMode]:RFNetWorkingRespSerializerJSON;
    
    _netWorking = [RFNetWorking netWorkingWithUrl:url andMethod:method andHeaders:headers andParams:p andTimeOut:timeout andRespSerializer:mode ignoreError:isSilence];
    RACSignal *retSignal = isOnline?[_netWorking.signal replayLazily]:_netWorking.signal;
    //这里不存在循环引用，因为sign被申明为weak
#warning 这里在登录的时候存在无法释放的问题，暂时放下这个问题
//    @weakify(self)
    return [retSignal flattenMap:^RACStream *(id value) {
//        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            @strongify(self)
            BOOL isError = false;
            NSError *error = nil;
            if([value isKindOfClass:[NSError class]]){
                isError = true;
                error = value;
            }else if([param respondsToSelector:@selector(isResultValid:error:)]){
                isError = ![param isResultValid:value error:&error];
            }
            
            if(isError && isSilence){
                [subscriber sendCompleted];
            }else if(isError){
                [subscriber sendError:error];
            }else{
                NSObject* o ;

                if(entityClss){
                    [self getEntityFromJson:value entity:&o class:entityClss];
                }else{
                    o = value;
                }
                [subscriber sendNext:o];
                [subscriber sendCompleted];
            }
            return [RACDisposable disposableWithBlock:^{
                //            @strongify(_holdSignal);
                if(--_count == 0){
                    _signal = nil;
                }
            }];
        }];
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
            //实现了协议的类会自动添加以下属性：hash、description、superclass、debugDescription，需要过滤掉
            if([name isEqualToString:@"hash"] || [name isEqualToString:@"description"] || [name isEqualToString:@"superclass"] || [name isEqualToString:@"debugDescription"]){
                break;
            }
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
    if(*entity == nil){
        *entity = [cls new];
    }
    NSObject *ent = *entity;
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
                    @try {
                        id tmpJSON = [json objectForKey:jsonName];
                        if(tmpJSON==nil){
                            tmpJSON = [json objectForKey:[jsonName lowercaseString]];
                        }
                        if(tmpJSON==nil){
                            tmpJSON = [json objectForKey:[jsonName uppercaseString]];
                        }
                        if ([ent conformsToProtocol:@protocol(IRFEntity)] && [ent respondsToSelector:@selector(parseJson:byKey:)]) {
                            tmpJSON = [(id<IRFEntity>)ent parseJson:tmpJSON byKey:jsonName];
                        }
                        if ([tmpJSON isKindOfClass:[NSArray class]]) {
                            Class pkClass = nil;
                            if([ent conformsToProtocol:@protocol(IRFEntity)] && [ent respondsToSelector:@selector(getEntityClssByKey:)]){
                                pkClass = [(id<IRFEntity>)ent getEntityClssByKey:jsonName];
                            }
                            if (pkClass) {
                                NSMutableArray *array = [NSMutableArray array];
                                
                                NSArray *tmpArray = tmpJSON;
                                for (id tmp in tmpArray) {
                                    id ent = [[pkClass alloc] init];
                                    if ([ent isKindOfClass:[NSObject class]]) {
                                        id tmpJson = tmp;
                                        [self getEntityFromJson:tmpJson entity:&ent class:pkClass];
                                        [array addObject:ent];
                                    }else{
                                        [array addObject:tmp];
                                    }
                                    
                                }
                                [ent setValue:array forKey:name];
                            }else{
                                [ent setValue:tmpJSON forKey:name];
                            }
                        }else if([tmpJSON isKindOfClass:[NSDictionary class]]){
                            Class pkClass = nil;
                            NSDictionary *tmpDict = tmpJSON;
                            if([ent conformsToProtocol:@protocol(IRFEntity)] && [ent respondsToSelector:@selector(getEntityClssByKey:)]){
                                pkClass = [(id<IRFEntity>)ent getEntityClssByKey:jsonName];
                            }

                            if (pkClass) {
                                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                                for (NSString* key in [tmpDict allKeys]) {
                                    id ent = [[pkClass alloc] init];
                                    id tmp = [tmpDict objectForKey:key];
                                    if ([ent isKindOfClass:[NSObject class]]) {
                                        id tmpJson = tmp;
                                        [self getEntityFromJson:tmpJson entity:&ent class:pkClass];
                                        [dict setObject:ent forKey:key];
                                    }else{
                                        [dict setObject:tmp forKey:key];
                                    }
                                    
                                }
                                [ent setValue:dict forKey:name];
                            }else{
                                [ent setValue:tmpJSON forKey:name];
                            }
                        }else{
                            if (tmpJSON) {
                                
                                NSString *tmp = [NSString stringWithFormat:@"%s",property_getAttributes(prop) ];
                                NSRange range = [tmp rangeOfString:@"NSString"];
                                if (range.location != NSIntegerMax) {
                                    [ent setValue:[NSString stringWithFormat:@"%@",tmpJSON] forKey:name];
                                }else{
                                    [ent setValue:tmpJSON forKey:name];
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
                [self getEntityFromJson:json entity:&ent class:[cls superclass]];
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

-(RACSignal *)signal{
    _count++;
    return _signal;
}

-(void)dealloc{
    NSLog(@"+++++++RFNetAdapter has dealloced+++++++");
}

@end
