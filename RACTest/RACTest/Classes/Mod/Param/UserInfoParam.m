//
//  UserInfoParam.m
//  RACTest
//
//  Created by  rjt on 17/2/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UserInfoParam.h"
#import "UserInfoEntity.h"

@implementation UserInfoParam
-(NSString*)getPath{
    return @"/user/getuserinfo";
}

-(Class)getEntityClass{
    return [UserInfoEntity class];
}
@end
