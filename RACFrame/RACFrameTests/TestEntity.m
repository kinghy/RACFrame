//
//  TestEntity.m
//  RACFrame
//
//  Created by  rjt on 17/2/3.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "TestEntity.h"

@implementation TestEntity
-(Class)getEntityClssByKey:(NSString *)key{
    if([@"records" isEqualToString:key]){
        return [TestRecordsEntity class];
    }
    if([@"dict2" isEqualToString:key] || [@"dict3" isEqualToString:key]|| [@"dict4" isEqualToString:key]){
        return [TestDictEntity class];
    }
    return  nil;
}

-(id)parseJson:(id)dict byKey:(NSString *)key{
    if([@"dict3" isEqualToString:key]){
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        NSArray *a = [dict allKeys];
        for(NSString* k in a){
            NSMutableDictionary *td = [NSMutableDictionary dictionaryWithDictionary:dict[k]];
            [td setObject:k forKey:@"key"];
            [d setObject:td forKey:k];
        }
        return d;
    }
    if([@"dict4" isEqualToString:key]){
        NSMutableArray *array = [NSMutableArray array];
        NSArray *keys = [dict allKeys];
        for(NSString* k in keys){
            NSMutableDictionary *td = [NSMutableDictionary dictionaryWithDictionary:dict[k]];
            [td setObject:k forKey:@"key"];
            [array addObject:td];
        }
        [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [[obj1 objectForKey:@"key"] integerValue]>[[obj2 objectForKey:@"key"] integerValue];
        }];
        return array;
    }
    return dict;
}
@end

@implementation TestRecordsEntity

@end

@implementation TestDictEntity

@end
