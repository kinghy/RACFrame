//
//  STOSearchViewController.h
//  RACTest
//
//  Created by  rjt on 17/4/25.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STOSearchViewController : AppViewController

@property(nonatomic,strong)NSString *stockCode;
@property (weak, nonatomic) IBOutlet UIView *searchFrame;
@property (weak, nonatomic) IBOutlet UITextField *search;
@property (weak, nonatomic) IBOutlet UITableView *searchTab;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property(assign,nonatomic)BOOL backToIndex;

@property(nonatomic,assign)BOOL presented;

-(void)showCancelBtn;
-(void)hideCancelBtn;

//取消
-(void)clickCancel;

//返回上页
-(void)navBack;

//清空搜索框
-(void)clickClean;

//-(void)gotoSuperScheme:(STOSearchEntity *)entity;
@end
