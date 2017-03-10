//
//  PayViewController.h
//  RACTest
//
//  Created by  rjt on 17/2/15.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PayViewModel;

@interface PayViewController : AppViewController

+(instancetype)controllerWithViewModel:(PayViewModel*)viewModel;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(PayViewModel*)viewModel;

@property (weak, nonatomic) IBOutlet UITableView *payTableView;

@end
