//
//  PayDetailViewController.h
//  RACTest
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewController.h"
#import "PayDetailViewModel.h"

@interface PayDetailViewController : AppViewController<RFTableDelegate>
+(instancetype)controllerWithViewModel:(PayDetailViewModel*)viewModel;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(PayDetailViewModel*)viewModel;
@property (weak, nonatomic) IBOutlet UITableView *detailTable;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@end
