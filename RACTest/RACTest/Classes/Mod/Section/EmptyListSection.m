//
//  EmptyListSection.m
//  STO
//
//  Created by  rjt on 16/3/31.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "EmptyListSection.h"

@implementation EmptyListSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)sectionDidLoad{
    self.publishBtn.layer.cornerRadius = 2.f;
    self.publishBtn.layer.borderColor = Color_Bg_RGB(49, 121, 255).CGColor;
    self.publishBtn.layer.borderWidth = 1.f;
//    [self fillParent];
}

@end
