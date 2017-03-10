//
//  RACFrameTests.m
//  RACFrameTests
//
//  Created by  rjt on 17/1/12.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RACFrame.h"
#import "RFNetWorking.h"
//#import "RFNetAdapter.h"
//#import "Test2Param.h"
//#import "TestEntity.h"
//#import "LoginParam.h"
//#import "LoginEntity.h"
//#import "LoginOnlineParam.h"
//#import "LoginSilenceParam.h"
//#import "LoginOnlineSilenceParam.h"
//#import "LoginValidParam.h"
//#import <CocoaLumberjack/CocoaLumberjack.h>
//#import "RFMacro.h"
#import "RFDefaultsPersistManager.h"
#import "UserPersitance.h"

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
    RFNetWorking *net = [RFNetWorking netWorkingWithUrl:@"http://192.168.6.111:8116/update/inipatch" andMethod:RFNetWorkingMethodGet andHeaders:@{@"h1":@"h1v",@"h2":@"h3v"} andParams:@{@"version":@"v_2.1.0",@"ini_version":@"1.0"} andTimeOut:5 andRespSerializer:RFNetWorkingRespSerializerJSON ignoreError:NO];
    
//    RACSignal* signal = [net signal];
    
    [net.signal subscribeNext:^(id x) {
        NSLog(@"RFNetWorking = %@",x);
        [expectation fulfill];
    } error:^(NSError *error) {
        NSLog(@"RFNetWorking error= %@",error);
        [expectation fulfill];
    } completed:^{
        NSLog(@"RFNetWorking completed");
    }];
    
    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
    
    
}
//
//- (void)testSilencePostConnect {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    [[RFNetWorking netWorkingWithUrl:@"http://192.168.6.111:8116/update/inipatch" andMethod:kPostMethod andHeaders:@{@"h1":@"h1v",@"h2":@"h3v"} andParams:@{@"version":@"v_2.1.0",@"ini_version":@"1.0"} andTimeOut:5 ignoreError:YES].signal subscribeNext:^(id x) {
//        NSLog(@"RFNetWorking = %@",x);
//        [expectation fulfill];
//    } error:^(NSError *error) {
//        NSLog(@"RFNetWorking error= %@",error);
//        [expectation fulfill];
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//- (void)testGetConnect {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    [[RFNetWorking netWorkingWithUrl:@"http://192.168.6.111:8116/update/patchget" andMethod:kGetMethod andHeaders:@{@"h1":@"h1v",@"h2":@"h3v"} andParams:@{@"name":@"stock_list",@"stocktime":@"1483947633"} andTimeOut:5 ignoreError:NO].signal subscribeNext:^(id x) {
//        NSLog(@"RFNetWorking = %@",x);
//        [expectation fulfill];
//    } error:^(NSError *error) {
//        NSLog(@"RFNetWorking error= %@",error);
//        [expectation fulfill];
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//- (void)testIgnoreGetConnect {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    RFNetWorking* net = [RFNetWorking netWorkingWithUrl:@"http://192.168.6.111:8116/update/patchget"  andMethod:kGetMethod  andHeaders:@{@"h1":@"h1v",@"h2":@"h3v"} andParams:@{@"name":@"stock_list",@"stocktime":@"1483947633"} andTimeOut:5 ignoreError:NO];
//    [net.signal subscribeNext:^(id x) {
//        NSLog(@"RFNetWorking = %@",x);
//        [expectation fulfill];
//    } error:^(NSError *error) {
//        NSLog(@"RFNetWorking error= %@",error);
//        [expectation fulfill];
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//-(void)testAdapter{
//
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    LoginParam *param = [LoginParam new];
//    
//    param.logInID = @"11111111111";
//    param.password = @"111111";
//    param.logInType = @"2";
//    RFNetAdapter *adapter = [RFNetAdapter netAdapterWithParam:param];
//
//    __block int i=0;
//    
//    [adapter.signal subscribeNext:^(id x) {
//        if([x isKindOfClass:[LoginEntity class]]){
//            LoginEntity *e = (LoginEntity*)x;
//            XCTAssertNotNil(e.session_id);
//            if(++i==2){
//                [expectation fulfill];
//            }
//        }
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [adapter.signal subscribeNext:^(id x) {
//        if([x isKindOfClass:[LoginEntity class]]){
//            LoginEntity *e = (LoginEntity*)x;
//            XCTAssertNotNil(e.session_id);
//            if(++i==2){
//                [expectation fulfill];
//            }
//
//        }
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//
//
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//-(void)testHotAdapter{
//
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    LoginOnlineParam *param = [LoginOnlineParam new];
//    
//    param.logInID = @"11111111111";
//    param.password = @"111111";
//    param.logInType = @"2";
//    RFNetAdapter *adapter = [RFNetAdapter netAdapterWithParam:param];
//
//    __block int i=0;
//    
//    [adapter.signal subscribeNext:^(id x) {
//        if([x isKindOfClass:[LoginEntity class]]){
//            LoginEntity *e = (LoginEntity*)x;
//            XCTAssertNotNil(e.session_id);
//            if(++i==2){
//                [expectation fulfill];
//            }
//        }
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [adapter.signal subscribeNext:^(id x) {
//        if([x isKindOfClass:[LoginEntity class]]){
//            LoginEntity *e = (LoginEntity*)x;
//            XCTAssertNotNil(e.session_id);
//            if(++i==2){
//                [expectation fulfill];
//            }
//            
//        }
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//-(void)testAdapterError{
//
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    LoginParam *param = [LoginParam new];
//    
//    param.logInID = @"11111111111";
//    param.password = @"111111";
//    param.logInType = @"2";
//    
//    [[RFNetAdapter netAdapterWithParam:param].signal subscribeNext:^(id x) {
//        
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        [expectation fulfill];
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//-(void)testHotAdapterError{
//
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    LoginOnlineParam *param = [LoginOnlineParam new];
//    
//    param.logInID = @"11111111111";
//    param.password = @"111111";
//    param.logInType = @"2";
//    __block int i=0;
//    RFNetAdapter *net= [RFNetAdapter netAdapterWithParam:param];
//    [net.signal subscribeNext:^(id x) {
//        
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        if(++i==2){
//            [expectation fulfill];
//        }
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [net.signal subscribeNext:^(id x) {
//        
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        if(++i==2){
//            [expectation fulfill];
//        }
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//-(void)testAdapterSlience{
//
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    LoginSilenceParam *param = [LoginSilenceParam new];
//    
//    param.logInID = @"11111111111";
//    param.password = @"111111";
//    param.logInType = @"2";
//    
//    [[RFNetAdapter netAdapterWithParam:param].signal subscribeNext:^(id x) {
//        XCTFail(@"fail = %@",x);
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        XCTFail(@"fail = %@",error);
//    } completed:^{
//        [expectation fulfill];
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//-(void)testHotAdapterSlience{
//
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    LoginOnlineSilenceParam *param = [LoginOnlineSilenceParam new];
//    
//    param.logInID = @"11111111111";
//    param.password = @"111111";
//    param.logInType = @"2";
//    RACSignal *signal = [RFNetAdapter netAdapterWithParam:param].signal;
//    
//    __block int i=0;
//    
//    [signal subscribeNext:^(id x) {
//        XCTFail(@"fail = %@",x);
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        XCTFail(@"fail = %@",error);
//    } completed:^{
//        if(++i==2){
//            [expectation fulfill];
//        }
//
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [signal subscribeNext:^(id x) {
//        XCTFail(@"fail = %@",x);
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        XCTFail(@"fail = %@",error);
//    } completed:^{
//        if(++i==2){
//            [expectation fulfill];
//        }
//
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//-(void)testAdapterValid{
//
//    XCTestExpectation *expectation =[self expectationWithDescription:@"High Expectations"];
//    
//    LoginValidParam *param = [LoginValidParam new];
//    
//    param.logInID = @"11111111111";
//    param.password = @"22222";
//    param.logInType = @"2";
//    
//    RACSignal *signal = [RFNetAdapter netAdapterWithParam:param].signal;
//    __block int i=0;
//    [signal subscribeNext:^(id x) {
//        
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        if(++i==2){
//            [expectation fulfill];
//        }
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [signal subscribeNext:^(id x) {
//        
//    } error:^(NSError *error) {
//        NSLog(@"error = %@",error);
//        if(++i==2){
//            [expectation fulfill];
//        }
//    } completed:^{
//        NSLog(@"RFNetWorking completed");
//    }];
//    
//    [self waitForExpectationsWithTimeout:15.0 handler:^(NSError *error) {
//        if (error) {
//            NSLog(@"Timeout Error: %@", error);
//        }
//    }];
//}
//
//
//-(void)testDictFromParam{
//
//    Test2Param *param = [Test2Param new];
//    param.test1 = @"test11";
//    param.test2 = @"test21";
//    param.test3 = @"test31";
//    param.test4 = @"test41";
//    RFNetAdapter *adapter = [RFNetAdapter new];
//    
//    NSDictionary *dict = [adapter getDictFromParam:param class:[Test2Param class]];
//    XCTAssertEqual(dict[@"test1"], @"test11");
//    XCTAssertEqual(dict[@"test2"], @"test21");
//    XCTAssertEqual(dict[@"test3"], @"test31");
//    XCTAssertEqual(dict[@"test4"], @"test41");
//    
//    Test2Param *entity ;
//    [adapter getEntityFromJson:dict entity:&entity class:[Test2Param class]];
//    XCTAssertTrue([dict[@"test1"] isEqualToString:entity.test1]);
//    XCTAssertTrue([dict[@"test2"] isEqualToString:entity.test2]);
//    XCTAssertTrue([dict[@"test3"] isEqualToString:entity.test3]);
//    XCTAssertTrue([dict[@"test4"] isEqualToString:entity.test4]);
//    
//}
//
//-(void)testEntityFromJson{
//    RFNetAdapter *adapter = [RFNetAdapter new];
//    NSDictionary *dict =
//                    @{
//                        @"test":@"test1",
//                        @"test2":@"test12",
//                        @"records":@[
//                            @{@"record1":@"record11",@"record2":@"record21"},
//                            @{@"record1":@"record12",@"record2":@"record22",@"record3":@"record32"}
//                        ],
//                        @"records2":@[
//                            @{@"record21":@"record211",@"record22":@"record221"},
//                            @{@"record21":@"record212",@"record22":@"record222",@"record23":@"record232"}
//                        ],
//                        @"dict":@{
//                            @"d1":@"d11",
//                            @"d2":@"d21",
//                            @"d3":@"d31",
//                        },
//                        @"dict2":@{@"1":@{
//                                        @"d1":@"d12",
//                                        @"d2":@"d22",
//                                        @"d3":@"d32",
//                                        @"d4":@"d42"
//                                    },
//                                   @"2":@{
//                                           @"d1":@"d122",
//                                           @"d2":@"d222",
//                                           @"d3":@"d322",
//                                           @"d4":@"d422"
//                                           }
//                        },
//                        @"dict3":@{@"13":@{
//                                           @"d1":@"d123",
//                                           @"d2":@"d223",
//                                           @"d3":@"d323",
//                                           @"d4":@"d423"
//                                           },
//                                   @"23":@{
//                                           @"d1":@"d1223",
//                                           @"d2":@"d2223",
//                                           @"d3":@"d3223",
//                                           @"d4":@"d4223"
//                                           }
//                        },
//                        @"dict4":@{@"14":@{
//                                           @"d1":@"d1234",
//                                           @"d2":@"d2234",
//                                           @"d3":@"d3234",
//                                           @"d4":@"d4234"
//                                           },
//                                   @"24":@{
//                                           @"d1":@"d12234",
//                                           @"d2":@"d22234",
//                                           @"d3":@"d32234",
//                                           @"d4":@"d42234"
//                                           },
//                                   @"34":@{
//                                           @"d1":@"d122334",
//                                           @"d2":@"d222334",
//                                           @"d3":@"d322334",
//                                           @"d4":@"d422334"
//                                           }
//                                   },
//                    };
//    
//    TestEntity *entity = nil;
//    [adapter getEntityFromJson:dict entity:&entity class:[TestEntity class]];
//    
//    XCTAssertTrue([@"test1" isEqualToString:entity.test]);
//    XCTAssertNil(entity.records[0].record3);
//    XCTAssertTrue([@"record32" isEqualToString:entity.records[1].record3]);
//    XCTAssertNil([entity.records2[0] objectForKey:@"record23"]);
//    XCTAssertTrue([@"record232" isEqualToString:[entity.records2[1] objectForKey:@"record23"]]);
//    XCTAssertTrue([@"d31" isEqualToString:entity.dict[@"d3"]]);
//    XCTAssertTrue([@"d12" isEqualToString:entity.dict2[@"1"].d1]);
//    XCTAssertNil(entity.dict2[@"1"].key);
//    XCTAssertTrue([@"d322" isEqualToString:entity.dict2[@"2"].d3]);
//    
//    XCTAssertTrue([@"d3223" isEqualToString:entity.dict3[@"23"].d3]);
//    XCTAssertTrue([@"13" isEqualToString:entity.dict3[@"13"].key]);
//    
//    XCTAssertTrue([@"14" isEqualToString:entity.dict4[0].key]);
//    XCTAssertTrue([@"34" isEqualToString:entity.dict4[2].key]);
//    XCTAssertTrue(entity.dict4.count==3);
//}

-(void)testPersistance{
    id<IRFPersistManager> m = [RFDefaultsPersistManager sharedInstace];
    UserPersitance* u1 = (UserPersitance*)[m persistanceByClass:[UserPersitance class] andTag:@"user"];
    UserPersitance* u2 = (UserPersitance*)[m persistanceByClass:[UserPersitance class] andTag:@"user"];
    
    u1.uid = [[NSDate date] description];
    NSLog(@"u1.uid = %@",u1.uid);
    NSLog(@"u2.uid = %@",u2.uid);
    
    XCTAssertFalse([u2.uid isEqualToString:u1.uid]);
    [u1 commit];
    [u2 refresh];
    XCTAssertTrue([u2.uid isEqualToString:u1.uid]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
