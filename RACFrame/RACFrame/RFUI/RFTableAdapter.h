//
//  RFTableAdapter.h
//  RACFrame
//
//  Created by  rjt on 17/2/17.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RFTableAdapter : NSObject<UITableViewDataSource,UITableViewDelegate>
+(instancetype)adapterWithTable:(UITableView*)table andController:(id<RFTableDelegate>)controller andNibArray:(NSArray<NSString *>*)nibArray;
-(instancetype)initWithTable:(UITableView*)table andController:(id<RFTableDelegate>)controller andNibArray:(NSArray<NSString *>*)nibArray;

-(void)addEntity:(id)entity withSection:(Class)clss;
-(void)addEntities:(NSArray*)entities withSection:(Class)clss;
-(void)addSetEntity:(RFSetEntity*)entity;
-(void)addSplitWithColor:(UIColor*)color andHeight:(float)height;
-(void)addSplitWithColor:(UIColor*)color;
-(void)removeAll;


/**
 使用RAC绑定指定的数据源，一旦开启此功能，请不要再使用addEntity系列方法

 @param dsSignal 绑定数据源,例如RACObserve(_vm,records)
 @param clss 渲染用的section类
 @param emptyClss 数据为空时的渲染类
 */
-(void)bindDataSource:(RACSignal*)dsSignal withSection:(Class)clss andEmptySection:(Class)emptyClss;
/**
 解绑数据源
 */
-(void)unbindDataSource;

@end
