//
//  RFAspectsManager+Controller.m
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFAspectsManager+Controller.h"
#import <Aspects/Aspects.h>

@implementation RFAspectsManager (Controller)
#pragma mark - public methods
-(void)installControler{
    @weakify(self);
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        @strongify(self)
        [self after_viewDidLoad:aspectInfo.instance];
    } error:nil];
    
}

#pragma mark - private methods
-(void)after_viewDidLoad:(id)instance{
    for(id<RFControllerAspectInt> imp in _ctrlAspects){
        if ([imp respondsToSelector:@selector(after_viewDidLoad:)]) {
            [imp after_viewDidLoad:instance];
        }
    }
}

@end
