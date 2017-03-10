//
//  UITableView+RFUI.h
//  RACFrame
//
//  Created by  rjt on 17/2/17.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RFTableDelegate <NSObject>
@optional
-(void)rftable:(UITableView*)table forSection:(UIView*)section entity:(id)entity;
-(void)rftable:(UITableView*)table selectedSection:(UIView*)section entity:(id)entity;
/**
 首次初始化构造Section,并加入到cell之前调用
 @param section 初始化Section
 @param entity 初始化Entity
 */
-(void)rftable:(UITableView*)table willLoadSection:(UIView*)section entity:(id)entity;

/** 自定义构造初始化Section */
-(UIView*)rftable:(UITableView*)table initSectionClass:(Class)cls;

@end

@protocol IRFSection <NSObject>
@optional
-(void)sectionWillDidLoad;
-(void)sectionDidLoadWithEntity:(id)entity andCell:(UITableViewCell*)cell;
@end

@class RFTableAdapter;
@class RFSetSection;
@class RFSetEntity;
@interface UITableView (RFUI)
-(void)rftableWithController:(id<RFTableDelegate>)controller andNibArray:(NSArray<NSString *>*)nibArray;
-(void)addEntity:(id)entity withSection:(Class)clss;
-(void)addEntities:(NSArray*)entities withSection:(Class)clss;
-(void)addSplitWithColor:(UIColor*)color andHeight:(float)height;
-(void)addSplitWithColor:(UIColor*)color;
-(void)removeAllEntities;

@property (nonatomic,strong) RFTableAdapter* adapter;

@end
