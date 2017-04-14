//
//  ProfitsEntity.m
//  TPZ
//
//  Created by chenyi on 16/2/26.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "ProfitsEntity.h"

@implementation ProfitsEntity

-(id)formatJson:(id)dict{
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    NSMutableArray *records = [NSMutableArray array];
    [ret setObject:records forKey:@"records"];
    if([dict isKindOfClass:[NSDictionary class]]){
        NSDictionary* d = (NSDictionary*) dict;
        [d enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            NSMutableDictionary *tmp  = [NSMutableDictionary dictionaryWithDictionary:obj];
            [tmp setObject:key forKey:@"key_id"];
            [records addObject:tmp];
        }];
        
    }
    return ret;
}


-(Class)getEntityClssByKey:(NSString*)key{
    if([key isEqualToString:@"records"]){
        return [ProfitsRecordsEntity class];
    }
    return nil;
}
@end

@implementation ProfitsRecordsEntity


@end
