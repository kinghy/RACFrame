//
//  RFAspectsManager.m
//  RACFrame
//
//  Created by  rjt on 17/1/19.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFAspectsManager.h"
#import <Aspects/Aspects.h>

@implementation RFAspectsManager

#pragma mark - init methods
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static RFAspectsManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RFAspectsManager alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init{
    if(self = [super init]){
        _appAspects = [NSMutableArray<id<RFAppAspectInt>> array];
        _ctrlAspects = [NSMutableArray<id<RFControllerAspectInt>> array];
    }
    return self;
}

#pragma mark - public methods
-(void)registerAspect:(RFAspect*)aspect{
    if([aspect conformsToProtocol:@protocol(RFAppAspectInt)]){
        [_appAspects addObject:aspect];
    }
    if([aspect conformsToProtocol:@protocol(RFControllerAspectInt)]){
        [_ctrlAspects addObject:aspect];
    }
}

-(void)runWithAppDelegateClss:(Class<UIApplicationDelegate>)delegate{
    [self installAppWithDelegateClss:delegate];
    [self installControler];
}



@end

