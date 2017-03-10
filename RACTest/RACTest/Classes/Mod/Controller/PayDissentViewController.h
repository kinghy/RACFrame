//
//  PayDissentViewController.h
//  RACTest
//
//  Created by  rjt on 17/2/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewController.h"
#import "PayDetailViewModel.h"

@interface PayDissentViewController : AppViewController

+(instancetype)controllerWithViewModel:(PayDetailViewModel*)viewModel;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(PayDetailViewModel*)viewModel;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectTradeID;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectAntiPoint;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblTradeID;

@property (weak, nonatomic) IBOutlet UILabel *currentValue;
@property (weak, nonatomic) IBOutlet UITextField *myValueTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;


@property (weak, nonatomic) IBOutlet UIView *tableViewFrame;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@property (weak, nonatomic) IBOutlet UILabel *lblBuy;

@property (weak, nonatomic) IBOutlet UIImageView *imageBuy;

@property (weak, nonatomic) IBOutlet UIButton *btnBuy;

@property (weak, nonatomic) IBOutlet UILabel *lblSell;

@property (weak, nonatomic) IBOutlet UIImageView *imageSell;

@property (weak, nonatomic) IBOutlet UIButton *btnSell;

@property (weak, nonatomic) IBOutlet UILabel *lblProfit;

@property (weak, nonatomic) IBOutlet UIImageView *imageProfit;

@property (weak, nonatomic) IBOutlet UIButton *btnProfit;

@property (weak, nonatomic) IBOutlet UILabel *lblCheckOut;

@property (weak, nonatomic) IBOutlet UIButton *btnCheckOut;

@property (weak, nonatomic) IBOutlet UIImageView *imageCheckOut;

@property (weak, nonatomic) IBOutlet UILabel *lblTradeFee;

@property (weak, nonatomic) IBOutlet UIImageView *imageTradeFee;

@property (weak, nonatomic) IBOutlet UIButton *btnTradeFee;

@property (weak, nonatomic) IBOutlet UILabel *lblOther;

@property (weak, nonatomic) IBOutlet UIImageView *imageOther;

@property (weak, nonatomic) IBOutlet UIButton *btnOther;

@property (weak, nonatomic) IBOutlet UIButton *btnComplete;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dissentBottomConstraint;
@property (weak, nonatomic) IBOutlet UIButton *dissentHiddenBtn;


@property (weak, nonatomic) IBOutlet UIView *checkOutView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *buyView;
@property (weak, nonatomic) IBOutlet UIView *sellView;
@property (weak, nonatomic) IBOutlet UIView *settleView;
@property (weak, nonatomic) IBOutlet UIView *otherView;
@end
