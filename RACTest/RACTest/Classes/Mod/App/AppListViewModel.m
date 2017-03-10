//
//  AppListViewModel.m
//  RACTest
//
//  Created by  rjt on 17/3/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppListViewModel.h"

@implementation AppListViewModel
-(void)viewModelDidLoad{
    [super viewModelDidLoad];
    _dataSource = [[RFDataSource alloc] init];
}
@end
