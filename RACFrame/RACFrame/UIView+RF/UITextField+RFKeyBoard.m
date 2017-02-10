//
//  UITextField+RFKeyBoard.m
//  RACFrame
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UITextField+RFKeyBoard.h"
#import <objc/runtime.h>

static NSString *strValueKey = @"UITextField+RFKeyBoard_autoAdjustCoveredEditingstrValueKey";
static NSString *strShowKey = @"UITextField+RFKeyBoard_autoAdjustCoveredShow";
static NSString *strHideKey = @"UITextField+RFKeyBoard_autoAdjustCoveredHide";
static NSString *strbeginKey = @"UITextField+RFKeyBoard_autoAdjustCoveredEditingDidBegin";

@implementation UITextField (RFKeyBoard)
-(void)autoAdjustCovered{
    RACSignal *showSignal = objc_getAssociatedObject(self,&strShowKey);
    @weakify(self)
    if(showSignal==nil){
        showSignal = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UIKeyboardWillShowNotification" object:nil] takeUntil:self.rac_willDeallocSignal];
        [[showSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification *notification) {
            @strongify(self)
            [self keyboardWillShown:notification];
        }];
        //保证只能被开启一次
        objc_setAssociatedObject(self, &strShowKey, showSignal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    

    RACSignal *hideSignal = objc_getAssociatedObject(self,&strHideKey);
    if(hideSignal==nil){
        hideSignal = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UIKeyboardWillHideNotification" object:nil]  takeUntil:self.rac_willDeallocSignal];
        [hideSignal subscribeNext:^(NSNotification *notification) {
            @strongify(self)
            [self keyboardWillHidden:notification];
        }];
        //保证只能被开启一次
        objc_setAssociatedObject(self, &strHideKey, hideSignal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    RACSignal *beginSignal = objc_getAssociatedObject(self,&strbeginKey);
    if(beginSignal==nil){
        beginSignal = [self rac_signalForControlEvents:UIControlEventEditingDidBegin];
        [beginSignal subscribeNext:^(NSNotification *notification) {
            @strongify(self)
            NSValue *value = objc_getAssociatedObject(self,&strValueKey);
            if(value){
                [self adjustWithRect:[value CGRectValue]];
            }
        }];
        //保证只能被开启一次
        objc_setAssociatedObject(self, &strbeginKey, beginSignal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void) keyboardWillShown:(NSNotification *) notif{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    objc_setAssociatedObject(self, &strValueKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self adjustWithRect:[value CGRectValue]];
}

-(void)adjustWithRect:(CGRect)keyboardRect{
    if ([self isFirstResponder] && keyboardRect.origin.y>0) {
        NSLog(@"keyboardWillShown");
        UIView *screenView = [self getScreenView];
        
        CGRect absRect = [screenView convertRect:self.frame fromView:self];
        CGRect frame = screenView.frame;
        if ((absRect.origin.y+absRect.size.height + 90 + frame.origin.y) > (screenView.frame.size.height-keyboardRect.size.height) || frame.origin.y!=0) {
            const float movementDuration = 0.3f; // tweak as needed
            int movement = (screenView.frame.size.height -keyboardRect.size.height) - ( absRect.origin.y+absRect.size.height + 90 + frame.origin.y);
            movement = frame.origin.y+ movement>0?frame.origin.y*-1:movement;
            [UIView beginAnimations: @"anim" context: nil];
            
            [UIView setAnimationBeginsFromCurrentState: YES];
            
            [UIView setAnimationDuration: movementDuration];
            
            screenView.frame = CGRectOffset(screenView.frame, 0, movement);
            
            [UIView commitAnimations];
        }
        
    }
}

- (void) keyboardWillHidden:(NSNotification *) notif{
    if([self isFirstResponder]){
        NSLog(@"keyboardWillHidden");
        UIView *screenView = [self getScreenView];
        const float movementDuration = 0.3f; // tweak as needed
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        screenView.frame = CGRectMake(0,0,screenView.frame.size.width,screenView.frame.size.height);
        [UIView commitAnimations];
    }
}


//获取最外层view
-(UIView *)getScreenView{
    UIView * view = nil;
    view = [self superview];
    while (view && [view superview]) {
        view = [view superview];
    }
    return view;
}


@end
