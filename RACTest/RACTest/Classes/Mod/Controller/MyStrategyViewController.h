//
//  MyStrategyViewController.h
//  RACTest
//
//  Created by  rjt on 17/3/2.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewController.h"

@class MyStrategyViewModel;
@interface MyStrategyViewController : AppViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITableView *allTable;
@property (strong, nonatomic)  MyStrategyViewModel *allModel;
@property (weak, nonatomic) IBOutlet UITableView *todayTable;
@property (strong, nonatomic)  MyStrategyViewModel *todayModel;
@property (weak, nonatomic) IBOutlet UITableView *notlastTable;
@property (strong, nonatomic)  MyStrategyViewModel *notlastModel;
@property (weak, nonatomic) IBOutlet UITableView *lastTable;
@property (strong, nonatomic)  MyStrategyViewModel *lastModel;
@property (weak, nonatomic) IBOutlet UITableView *sellTable;
@property (strong, nonatomic)  MyStrategyViewModel *sellModel;
@end
