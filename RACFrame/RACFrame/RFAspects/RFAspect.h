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
dynamic aspectPlaceHolder;\
+(void)load{\
[[RFAspectsManager sharedInstance] registerAspect:[self new]];\
}\

@interface RFAspect : NSObject

/**
 无任何实质用处的变量，只是为了让REGISTER_AS_ASPECTS宏写法更美观
 */
@property (nonatomic) int aspectPlaceHolder;
@end
