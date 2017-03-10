//
//  RFSplitSection.m
//  RACFrame
//
//  Created by  rjt on 17/2/28.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFSplitSection.h"
#import "RFSplitEntity.h"
@implementation RFSplitSection

-(void)sectionDidLoadWithEntity:(id)entity andCell:(UITableViewCell *)cell{

    if([entity isKindOfClass:[RFSplitEntity class]]){
        CGRect rect = self.frame;
        rect.origin.y = 0;
        rect.origin.x = 0;
        rect.size.height = ((RFSplitEntity*)entity).sectionHeight;
        self.frame = rect;
        self.backgroundColor = ((RFSplitEntity*)entity).bgColor;
    }
    
}

@end
