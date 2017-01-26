//
//  RFAspectsManager.h
//  RACFrame
//
//  Created by  rjt on 17/1/19.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RFAppAspectInt;
@protocol RFControllerAspectInt;

@interface RFAspectsManager : NSObject{
    NSMutableArray<id<RFAppAspectInt>>* _appAspects;
    NSMutableArray<id<RFControllerAspectInt>>* _ctrlAspects;
}
+(instancetype)sharedInstance;

/**
 安装RFAspectsManager，需要在AppDelegate中调用，以正确完成AOP的安装,需切仅需执行一次
 */
-(void)runWithAppDelegateClss:(Class<UIApplicationDelegate>)delegate;

/**
 注册AOP实例
 @param aspect AOP实例
 */
-(void)registerAspect:(RFAspect*)aspect;
@end




