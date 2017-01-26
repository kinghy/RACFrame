//
//  RFAspectsManager+AppDelegate.m
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFAspectsManager+AppDelegate.h"
#import <Aspects/Aspects.h>

@implementation RFAspectsManager (AppDelegate)
#pragma mark - public methods
-(void)installAppWithDelegateClss:(Class<UIApplicationDelegate>)delegateClss{
    @weakify(self);
    [(id)delegateClss aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, id p1,id p2){
        @strongify(self)
        [self after_application:p1 didFinishLaunchingWithOptions:p2 andInstance:aspectInfo.instance];
    } error:nil];
    [(id)delegateClss aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo, id p1,id p2){
        @strongify(self)
        [self before_application:p1 didFinishLaunchingWithOptions:p2 andInstance:aspectInfo.instance];
    } error:nil];

}
#pragma mark - private methods
-(void)after_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance{
    for(id<RFAppAspectInt> imp in _appAspects){
        if ([imp respondsToSelector:@selector(after_application:didFinishLaunchingWithOptions:andInstance:)]) {
            [imp after_application:application didFinishLaunchingWithOptions:launchOptions andInstance:instance];
        }
    }
}

-(void)before_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance{
    for(id<RFAppAspectInt> imp in _appAspects){
        if ([imp respondsToSelector:@selector(before_application:didFinishLaunchingWithOptions:andInstance:)]) {
            [imp before_application:application didFinishLaunchingWithOptions:launchOptions andInstance:instance];
        }
    }
}

@end
