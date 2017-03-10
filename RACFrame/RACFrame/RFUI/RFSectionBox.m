//
//  RFSectionBox.m
//  RACTest
//
//  Created by  rjt on 17/2/16.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFSectionBox.h"

@implementation RFSectionBox
+(instancetype)boxWithEntity:(id)entity andSectionClass:(Class)sectionClss andSectionHeight:(NSInteger)height{
    RFSectionBox *b = [self new];
    b.sectionClss =  sectionClss;
    b.entity = entity;
    b.sectionHeight = height;
    return b;
}

-(void)dealloc{
    NSLog(@"RFSectionBox has dealloced");
}

@end
