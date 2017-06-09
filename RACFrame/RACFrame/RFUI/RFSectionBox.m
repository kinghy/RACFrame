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
    return  [self boxWithEntity:entity andSectionClass:sectionClss andSectionHeight:height andTag:nil];
}

+(instancetype)boxWithEntity:(id)entity andSectionClass:(Class)sectionClss andSectionHeight:(NSInteger)height andTag:(NSString*)tag{
    RFSectionBox *b = [self new];
    b.sectionClss =  sectionClss;
    b.entity = entity;
    b.sectionHeight = height;
    b.tag = tag;
    return b;
}

-(void)dealloc{
    NSLog(@"RFSectionBox has dealloced");
}

@end
