//
//  SettlementsEntity.m
//  TPZ
//
//  Created by chenyi on 16/2/26.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "SettlementsEntity.h"

@implementation SettlementsEntity
-(Class)getEntityClssByKey:(NSString *)key{
    if([key isEqualToString:@"records"]){
        return [SettlementsRecordsEntity class];
    }
    return nil;
}
@end


@implementation SettlementsRecordsEntity

@end
