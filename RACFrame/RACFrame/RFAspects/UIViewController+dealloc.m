//
//  UIViewController+dealloc.m
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIViewController+dealloc.h"

@implementation UIViewController (dealloc)
-(void)dealloc{
    DDLogInfo(@"%@ has dealloced",[self class]);
}
@end
