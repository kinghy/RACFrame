//
//  RFCocoaLumberjackAspect.m
//  RACFrame
//
//  Created by  rjt on 17/1/20.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFCocoaLumberjackAspect.h"
#import "DDLog.h"

@implementation RFCocoaLumberjackAspect

//注册
@REGISTER_AS_ASPECTS

#pragma mark - RFAppAspectInt methods
//实现切片
-(void)before_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance{
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
//    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
//    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
//    [DDLog addLogger:fileLogger];

//    DDLogVerbose(@"Verbose");
//    DDLogDebug(@"Debug");
//    DDLogInfo(@"Info");
//    DDLogWarn(@"Warn");
//    DDLogError(@"Error");
}

#pragma mark - RFControllerAspectInt methods
-(void)after_viewDidLoad:(id)instance{
    DDLogInfo(@"%@ did Load",[instance class]);
}

@end
