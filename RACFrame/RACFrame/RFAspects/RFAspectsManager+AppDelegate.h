//
//  RFAspectsManager+AppDelegate.h
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFAspectsManager.h"
/**
 AppDeleggate切片接口
 */
@protocol RFAppAspectInt <NSObject>
@optional
- (void)after_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance;
- (void)before_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance;
@end

@interface RFAspectsManager (AppDelegate)
-(void)installAppWithDelegateClss:(Class<UIApplicationDelegate>)delegateClss;
@end
