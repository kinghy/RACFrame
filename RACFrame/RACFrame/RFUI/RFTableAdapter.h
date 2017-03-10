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


@end
