//
//  UIScrollView+RFUI.h
//  RACFrame
//
//  Created by  rjt on 17/2/17.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 代理的协议定义
 */
@protocol RFRefreshDelegate <NSObject>
@optional
// 开始进入刷新状态就会调用
- (void)refresh:(UIScrollView*)view headerBeginRefreshing:(MJRefreshComponent *)refreshView withObject:(NSObject*)obj;

// 开始进入刷新状态就会调用
- (void)refresh:(UIScrollView*)view footerBeginRefreshing:(MJRefreshComponent *)refreshView withObject:(NSObject*)obj;

@end

@interface UIScrollView (RFUI)
-(void)rfrefreshWithController:(id<RFRefreshDelegate>)controller andObject:(NSObject*)obj;

-(void)endHeaderRefreshing;
-(void)endFooterRefreshingWithNoMoreData:(BOOL)noMoreData;

@property (nonatomic,strong) id<RFRefreshDelegate> refreshController;
@property (nonatomic,strong) NSObject* refreshObject;

@end
