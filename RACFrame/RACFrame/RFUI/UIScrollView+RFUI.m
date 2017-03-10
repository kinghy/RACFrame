//
//  UIScrollView+RFUI.m
//  RACFrame
//
//  Created by  rjt on 17/2/17.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "UIScrollView+RFUI.h"

@implementation UIScrollView (RFUI)
static NSString *controllerKey = @"controllerKey";
static NSString *objectKey = @"objectKey";
NSString *const MJRefreshFooterPullToRefresh = @"上拉即可翻页";
NSString *const MJRefreshFooterReleaseToRefresh = @"释放即可翻页";
NSString *const MJRefreshFooterRefreshing = @"加载中";

NSString *const MJRefreshHeaderPullToRefresh = @"下拉即可刷新";
NSString *const MJRefreshHeaderReleaseToRefresh = @"释放即可刷新";
NSString *const MJRefreshHeaderRefreshing = @"加载中";
#pragma mark - init methods

#pragma mark - extends methods

#pragma mark - public methods
-(void)rfrefreshWithController:(id<RFRefreshDelegate>)controller andObject:(NSObject *)obj{
    self.refreshController = controller;
    self.refreshObject = obj;

    MJRefreshNormalHeader *refreshHeaderView = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 设置文字
    [refreshHeaderView setTitle:MJRefreshHeaderPullToRefresh forState:MJRefreshStateIdle];
    [refreshHeaderView setTitle:MJRefreshHeaderReleaseToRefresh forState:MJRefreshStatePulling];
    [refreshHeaderView setTitle:MJRefreshHeaderRefreshing forState:MJRefreshStateRefreshing];
    refreshHeaderView.lastUpdatedTimeLabel.hidden = YES;
    // 下拉刷新
    self.mj_header = refreshHeaderView ;
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.mj_header.automaticallyChangeAlpha = YES;

    //上拉翻页
    MJRefreshBackNormalFooter *refreshFooterView = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextData)];
    // 设置文字
    [refreshFooterView setTitle:MJRefreshFooterPullToRefresh forState:MJRefreshStateIdle];
    [refreshFooterView setTitle:MJRefreshFooterReleaseToRefresh forState:MJRefreshStatePulling];
    [refreshFooterView setTitle:MJRefreshFooterRefreshing forState:MJRefreshStateRefreshing];
    
    self.mj_footer = refreshFooterView;
    
}


-(void)endHeaderRefreshing{
    [self.mj_header endRefreshing];
}

-(void)endFooterRefreshingWithNoMoreData:(BOOL)noMoreData{
    if(noMoreData){
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer endRefreshing];
    }
}
#pragma mark - private methods
-(void)loadNewData{
    if([self.refreshController respondsToSelector:@selector(refresh:headerBeginRefreshing:withObject:)]){
        [self.refreshController refresh:self headerBeginRefreshing:self.mj_header withObject:self.refreshObject];
    }
}
-(void)loadNextData{
    if([self.refreshController respondsToSelector:@selector(refresh:footerBeginRefreshing:withObject:)]){
        [self.refreshController refresh:self footerBeginRefreshing:self.mj_footer withObject:self.refreshObject];
    }
}
#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods
-(void)setRefreshController:(id<RFRefreshDelegate>)controller{
    objc_setAssociatedObject(self, &controllerKey, controller, OBJC_ASSOCIATION_ASSIGN);
}

-(id<RFRefreshDelegate>)refreshController{
    return objc_getAssociatedObject(self, &controllerKey);
}

-(void)setRefreshObject:(NSObject *)refreshObject{
    objc_setAssociatedObject(self, &objectKey, refreshObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSObject *)refreshObject{
    return objc_getAssociatedObject(self, &objectKey);
}


@end
