//
//  PatchgetPersistance.h
//  RACTest
//
//  Created by  rjt on 17/4/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kStockPathgetPersistanceKey @"kStockPathgetPersistanceKey"

@interface PatchgetPersistance : RFPersistance
@property(assign,nonatomic)NSString *name;
@property(assign,nonatomic)NSString *version;
@property(assign,nonatomic)NSString *create_time;
@property(assign,nonatomic)NSString *flag;
@property(assign,nonatomic)NSString *url;
@end
