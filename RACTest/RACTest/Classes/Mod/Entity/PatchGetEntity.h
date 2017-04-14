//
//  PatchGetEntity.h
//  Metal
//
//  Created by chenyi on 15/8/27.
//  Copyright (c) 2015年 JYZD. All rights reserved.
//

@interface PatchGetEntity : NSObject<IRFEntity>
@property(strong,nonatomic) NSString *error_code;
@property(strong,nonatomic) NSString *error_msg;
@property(strong,nonatomic) NSDictionary* res_data;

@end

