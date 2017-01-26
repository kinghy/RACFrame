//
//  RACFrameTests.m
//  RACFrameTests
//
//  Created by  rjt on 17/1/12.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RFNetWorking.h"
#import "RFNetAdapter.h"

@interface RACFrameTests : XCTestCase

@end

@implementation RACFrameTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPostConnect {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];

    [[[RFNetWorking netWorking] postWithUrl:@"http://192.168.6.111:8116/update/inipatch" andHeaders:@{@"h1":@"h1v",@"h2":@"h3v"} andParams:@{@"version":@"v_2.1.0",@"ini_version":@"1.0"} andTimeOut:5] subscribeNext:^(id x) {
        NSLog(@"RFNetWorking = %@",x);
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"RFNetWorking error= %@",error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testGetConnect {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
    [[[RFNetWorking netWorking] getWithUrl:@"http://192.168.6.111:8116/update/patchget" andHeaders:@{@"h1":@"h1v",@"h2":@"h3v"} andParams:@{@"name":@"stock_list",@"stocktime":@"1483947633"} andTimeOut:5] subscribeNext:^(id x) {
        NSLog(@"RFNetWorking = %@",x);
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"RFNetWorking error= %@",error);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

-(void)testAdapter{
    int times = 10;
    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
    [[[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] scanWithStart:@0 reduceWithIndex:^id(id running, id next, NSUInteger index) {
        return [NSNumber numberWithInteger:index];
    }] takeUntilBlock:^BOOL(id x) {
        return [x intValue]>=times;
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];

    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

-(void)getDictFromParam{
//    [[RFNetAdapter netAdapter] performSelector:<#(nonnull SEL)#> withObject:nil afterDelay:<#(NSTimeInterval)#>];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
