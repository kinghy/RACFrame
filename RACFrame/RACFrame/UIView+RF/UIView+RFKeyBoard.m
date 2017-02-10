//
//  UIView+RFKeyBoard.m
//  RACFrame
//
//  Created by  rjt on 17/2/7.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIView+RFKeyBoard.h"
#import <objc/runtime.h>

@implementation UIView (RFKeyBoard)
-(void)autoHideKeyBoard{
    static NSString *strKey = @"UIView+RFKeyBoard_autoHideKeyBoard";
    UITapGestureRecognizer *singleTap = objc_getAssociatedObject(self,&strKey);
    if(singleTap==nil){
        singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
        [self addGestureRecognizer:singleTap];
        //保证只能被开启一次
        objc_setAssociatedObject(self, &strKey, singleTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
//    [[self rac_signalForSelector:@selector(hitTest:withEvent:)] subscribeNext:^(id x) {
//        NSLog(@"rac_signalForSelector:@selector(hitTest:withEvent:)]");
//    }];
//    
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    [self endEditing:YES];
}

@end
