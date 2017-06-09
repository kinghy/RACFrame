//
//  AdEntity.m
//  A50
//
//  Created by  rjt on 15/10/19.
//  Copyright © 2015年 JYZD. All rights reserved.
//

#import "AdEntity.h"

@implementation AdEntity
-(Class)getEntityClssByKey:(NSString *)key{
    if([key isEqualToString:@"records"]){
        return [AdRecordsEntity class];
    }
    return nil;
}
@end

@implementation AdRecordsEntity

@end
