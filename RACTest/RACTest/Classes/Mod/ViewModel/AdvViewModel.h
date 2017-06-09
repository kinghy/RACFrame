//
//  AdvViewModel.h
//  RACTest
//
//  Created by  rjt on 17/5/24.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AdRecordsEntity;
@interface AdvViewModel : AppListViewModel
-(void)showAdv:(AdRecordsEntity*)entity withNav:(UINavigationController*)nav;
@end
