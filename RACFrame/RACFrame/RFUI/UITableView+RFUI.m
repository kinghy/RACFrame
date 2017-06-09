//
//  UITableView+RFUI.m
//  RACFrame
//
//  Created by  rjt on 17/2/17.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UITableView+RFUI.h"
#import "RFTableAdapter.h"

@implementation UITableView (RFUI)
static NSString *adapterKey = @"adapterKey";

#pragma mark - init methods

#pragma mark - extends methods

#pragma mark - public methods
-(void)rftableWithController:(id<RFTableDelegate>)controller andNibArray:(NSArray<NSString *>*)nibArray{
    self.adapter = [RFTableAdapter adapterWithTable:self andController:controller andNibArray:nibArray];
}

-(void)addSplitWithColor:(UIColor *)color{
    [self.adapter addSplitWithColor:color];
}

-(void)addSplitWithColor:(UIColor *)color andHeight:(float)height{
    [self.adapter addSplitWithColor:color andHeight:height];
}

-(void)addEntity:(id)entity withSection:(Class)clss{
    [self.adapter addEntity:entity withSection:clss];
}

-(void)addEntity:(id)entity withSection:(Class)clss andTag:(NSString*)tag{
    [self.adapter addEntity:entity withSection:clss andTag:tag];
}

-(void)addEntities:(NSArray*)entities withSection:(Class)clss{
    [self.adapter addEntities:entities withSection:clss];
}

-(void)replaceEntity:(id)entity withTag:(NSString *)tag{
    [self.adapter replaceEntity:entity withTag:tag];
}

-(void)replaceWithTag:(NSString *)tag byBlock:(ReplaceBlock)block{
    [self.adapter replaceWithTag:tag byBlock:block];
}

-(void)removeAllEntities{
    [self.adapter removeAll];
}

-(void)bindDataSource:(RACSignal *)dsSignal withSection:(Class)clss andEmptySection:(Class)emptyClss{
    [self.adapter bindDataSource:dsSignal withSection:clss andEmptySection:emptyClss];
}

-(void)unbindDataSource{
    [self.adapter unbindDataSource];
}

#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods

-(void)setAdapter:(RFTableAdapter *)adapter{
    objc_setAssociatedObject(self, &adapterKey, adapter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)adapter{
    return objc_getAssociatedObject(self, &adapterKey);
}
@end
