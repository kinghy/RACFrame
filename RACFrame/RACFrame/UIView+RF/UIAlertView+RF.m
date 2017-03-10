//
//  UIAlertView+RF.m
//  RACFrame
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIAlertView+RF.h"
static NSString *strKey = @"UIAlertView+RF_alertOneBtnWithWithTitle";
@interface UIAlertView ()<UIAlertViewDelegate>

@end
@implementation UIAlertView (RF)
+(instancetype)alertOneBtnWithWithTitle:(NSString *)title message:(NSString *)msg btnTitle:(NSString *)btnTitle clickedBlock:(void (^)(UIAlertView *))block{
    objc_setAssociatedObject(self, &strKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:btnTitle otherButtonTitles: nil];
}

-(void)alertViewCancel:(UIAlertView *)alertView{
    void (^block)(UIAlertView *) = objc_getAssociatedObject(self, &strKey);
    if(block){
        block(alertView);
    }
}
@end
