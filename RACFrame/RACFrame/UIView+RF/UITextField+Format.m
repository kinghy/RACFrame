//
//  UITextField+Format.m
//  RACFrame
//
//  Created by  rjt on 17/2/23.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UITextField+Format.h"
#import "NSString+RFValidate.h"

@implementation UITextField (Format)
#pragma mark - init methods

#pragma mark - extends methods

#pragma mark - public methods
-(void)numberFormatWithDelegate:(id<UITextFieldDelegate>)delegate{
    [self swizzlingDelegate:delegate exchangetoSelector:@selector(mergNumberTextField:shouldChangeCharactersInRange:replacementString:) orAddSelector:@selector(numberTextField:shouldChangeCharactersInRange:replacementString:)];
}

-(void)mobileFormatWithDelegate:(id<UITextFieldDelegate>)delegate{
    [self swizzlingDelegate:delegate exchangetoSelector:@selector(mergMobileTextField:shouldChangeCharactersInRange:replacementString:) orAddSelector:@selector(mobileTextField:shouldChangeCharactersInRange:replacementString:)];
    [[self rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField* x){
        x.text = [x.text formatMobile];
    }];
}
#pragma mark - private methods

- (BOOL)mobileTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* str1 = [NSMutableString stringWithString:textField.text];
    [str1 insertString:string atIndex:range.location];
    return [[NSString stringWithString:str1] validateInputMobile];
}

- (BOOL)mergMobileTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL flg = [textField mergMobileTextField:textField shouldChangeCharactersInRange:range replacementString:string];//这里运行的是deleagate替换之前的方法,讲两个方法的返回结果合并得到最后结果;
    NSMutableString* str1 = [NSMutableString stringWithString:textField.text];
    [str1 insertString:string atIndex:range.location];
    return flg && [[NSString stringWithString:str1] validateInputMobile];
}

- (BOOL)numberTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString* str1 = [NSMutableString stringWithString:textField.text];
    [str1 insertString:string atIndex:range.location];
    return [[NSString stringWithString:str1] validateNumber];
}

- (BOOL)mergNumberTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL flg = [textField mergNumberTextField:textField shouldChangeCharactersInRange:range replacementString:string];//这里运行的是deleagate替换之前的方法,讲两个方法的返回结果合并得到最后结果;
    NSMutableString* str1 = [NSMutableString stringWithString:textField.text];
    [str1 insertString:string atIndex:range.location];
    return flg && [[NSString stringWithString:str1] validateNumber];
}

-(void)swizzlingDelegate:(id<UITextFieldDelegate>)delegate exchangetoSelector:(SEL)toSel orAddSelector:(SEL)addSel{
    if(!self.delegate){
        self.delegate = delegate;
    }
    SEL delegateSEL = @selector(textField:shouldChangeCharactersInRange:replacementString:);
    // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method fromMethod = class_getInstanceMethod([self.delegate class], delegateSEL);
    Method toMethod = class_getInstanceMethod([self class], toSel);
    if([self.delegate respondsToSelector:delegateSEL]){
        method_exchangeImplementations(fromMethod, toMethod);
    }else{
        class_addMethod([self.delegate class], delegateSEL, class_getMethodImplementation([self class],addSel), "b@:@:@:@");
    }
}
#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods




@end
