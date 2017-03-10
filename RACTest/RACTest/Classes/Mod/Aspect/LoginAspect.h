//
//  LoginAspect.h
//  RACFrame
//
//  Created by  rjt on 17/1/20.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFAspect.h"

@interface LoginAspect : RFAspect<RFAppAspectInt>
- (void)before_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance;
@end
