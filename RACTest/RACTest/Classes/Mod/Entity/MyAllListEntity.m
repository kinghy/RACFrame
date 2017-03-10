//
//  MyAllListEntity.m
//  STO
//
//  Created by chenyi on 16/6/27.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "MyAllListEntity.h"

@implementation MyAllListEntity
-(Class)getEntityClssByKey:(NSString *)key{
    if([key isEqualToString:@"records"]){
        return [MyAllListRecordsEntity class];
    }
    return nil;
}
@end

@implementation MyAllListRecordsEntity


@end
