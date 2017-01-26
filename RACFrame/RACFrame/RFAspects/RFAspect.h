//
//  RFAspect.h
//  RACFrame
//
//  Created by  rjt on 17/1/20.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

//AOP注册宏
#define REGISTER_AS_ASPECTS \
+(void)load{\
[[RFAspectsManager sharedInstance] registerAspect:[self new]];\
}\

@interface RFAspect : NSObject

@end
