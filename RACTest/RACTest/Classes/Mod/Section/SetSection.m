//
//  SetSection.m
//  RACTest
//
//  Created by  rjt on 17/2/28.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "SetSection.h"

@interface SetSection ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLineLeadingConstraint;
@end

@implementation SetSection

-(void)sectionWillDidLoad{
    self.topLineView.backgroundColor = kSplitLineColor;
    self.topLineView.hidden = YES;
    self.bottomLineView.backgroundColor = kSplitLineColor;
    self.bottomLineView.hidden = YES;
}

-(void)setTopLineIndent:(float)topLineIndent{
    _topLineIndent = topLineIndent;
    _topLineLeadingConstraint.constant = topLineIndent;
}

-(void)setBottomLineIndent:(float)bottomLineIndent{
    _bottomLineIndent = bottomLineIndent;
    _bottomLineLeadingConstraint.constant = bottomLineIndent;
}

@end
