//
//  RFSectionBox.h
//  RACTest
//
//  Created by  rjt on 17/2/16.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFSectionBox : NSObject
+(instancetype)boxWithEntity:(id)entity andSectionClass:(Class)sectionClss andSectionHeight:(NSInteger)height;
+(instancetype)boxWithEntity:(id)entity andSectionClass:(Class)sectionClss andSectionHeight:(NSInteger)height andTag:(NSString*)tag;
@property (nonatomic,strong) UIView* section;
@property (nonatomic,strong) id entity;

/**
 section高度，在section没有被分配时框架会取此值作为初始值，如果section被分配则不再使用此值
 */
@property (nonatomic) NSInteger sectionHeight;
@property (nonatomic,strong) Class sectionClss;
@property (nonatomic,strong) NSString *tag;
@end
