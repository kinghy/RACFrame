//
//  VerifySecurityCodeParam.h
//  RACTest
//
//  Created by  rjt on 17/2/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppParam.h"

@interface VerifySecurityCodeParam : AppParam
@property(strong,nonatomic)NSString* code;
@property(strong,nonatomic)NSString* UUID;
@end
