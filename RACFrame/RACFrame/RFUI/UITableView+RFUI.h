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
-(void)addEntity:(id)entity withSection:(Class)clss andTag:(NSString*)tag;
-(void)replaceEntity:(id)entity withTag:(NSString*)tag;
-(void)replaceWithTag:(NSString *)tag byBlock:(ReplaceBlock)block;

-(void)addEntities:(NSArray*)entities withSection:(Class)clss;
-(void)addSplitWithColor:(UIColor*)color andHeight:(float)height;
-(void)addSplitWithColor:(UIColor*)color;
-(void)removeAllEntities;
/**
 使用RAC绑定指定的数据源，一旦开启此功能，请不要再使用addEntity系列方法
 
 @param dsSignal 绑定数据源,例如RACObserve(_vm,records)
 @param clss 渲染用的section类
 */
-(void)bindDataSource:(RACSignal*)dsSignal withSection:(Class)clss andEmptySection:(Class)emptyClss;
/**
 解绑数据源
 */
-(void)unbindDataSource;
@property (nonatomic,strong) RFTableAdapter* adapter;

@end
