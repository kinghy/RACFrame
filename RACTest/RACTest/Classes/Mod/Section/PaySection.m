//
//  PaySection.m
//  STO
//
//  Created by  rjt on 16/12/27.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "PaySection.h"
static int i = 0;
@implementation PaySection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    NSLog(@"begin i = %d",i++);
}

-(void)sectionWillDidLoad{
    _doBtn.layer.borderColor = kBtnBlueColor.CGColor;
    _doBtn.layer.borderWidth = .5f;
    _doBtn.layer.cornerRadius = 3;
    [_doBtn setTitleColor:kBtnBlueColor forState:UIControlStateNormal];
    [_doBtn setTitleColor:kTextGrayColor forState:UIControlStateDisabled];
    
}

-(void)dealloc{
    NSLog(@"PaySection has dealloced");
    NSLog(@"end i = %d",i--);
}

@end
