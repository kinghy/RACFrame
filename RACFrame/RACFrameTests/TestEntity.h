//
//  TestEntity.h
//  RACFrame
//
//  Created by  rjt on 17/2/3.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RFNetAdapter.h"

@class TestRecordsEntity;
@class TestDictEntity;
@interface TestEntity : NSObject<RFEntityInt>

@property (strong,nonatomic) NSString* test;
@property (strong,nonatomic) NSMutableArray<TestRecordsEntity*>* records;
@property (strong,nonatomic) id records2;
@property (strong,nonatomic) NSDictionary* dict;
@property (strong,nonatomic) NSDictionary<NSString*,TestDictEntity*>* dict2;
@property (strong,nonatomic) NSDictionary<NSString*,TestDictEntity*>* dict3;
@property (strong,nonatomic) NSMutableArray<TestDictEntity*>* dict4;
@end

@interface TestRecordsEntity:NSObject
@property (strong,nonatomic) NSString* record1;
@property (strong,nonatomic) NSString* record2;
@property (strong,nonatomic) NSString* record3;
@end

@interface TestDictEntity:NSObject
@property (strong,nonatomic) NSString* d1;
@property (strong,nonatomic) NSString* d2;
@property (strong,nonatomic) NSString* d3;
@property (strong,nonatomic) NSString* key;
@end
