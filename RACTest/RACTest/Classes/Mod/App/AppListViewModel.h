//
//  AppListViewModel.h
//  RACTest
//
//  Created by  rjt on 17/3/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewModel.h"

@interface AppListViewModel : AppViewModel
@property (nonatomic,strong) RFDataSource* dataSource;

/**
 更新，子类必须实现
 */
-(void)renew;
/**
 翻页，子类必须实现
 */
-(void)turning;
@end
