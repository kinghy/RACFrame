//
//  STOSearchViewController.m
//  RACTest
//
//  Created by  rjt on 17/4/25.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "STOSearchViewController.h"
#import "STOSearchViewModel.h"
#import "StockSection.h"
#import "StockPersistance.h"

@interface STOSearchViewController ()<RFTableDelegate>{
    STOSearchViewModel* _viewModel;
}


@end

@implementation STOSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - init methods

#pragma mark - extends methods
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:NO statusBarStyle:UIStatusBarStyleDefault title:@"股票搜索"];
}

-(void)bindViewModel{
    _viewModel = [STOSearchViewModel new];
    RAC(_viewModel,keywords) =  _search.rac_textSignal;
    
    [self.searchTab rftableWithController:self andNibArray:@[@"StockSection"]];

    [self.searchTab bindDataSource:_viewModel.dataSource.recordsSignal withSection:[StockSection class] andEmptySection:nil];
}

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - delegate methods
-(void)rftable:(UITableView *)table forSection:(UIView *)section entity:(id)entity{
    if([section isKindOfClass:[StockSection class]]){
        StockSection* s = (StockSection*)section;
        StockPersistance* e = (StockPersistance*)entity;
        s.codeLabel.text = e.code;
        s.nameLabel.text = e.name;
        s.kindLabel.text = e.shsz;
    }
}
#pragma mark - Action methods

#pragma mark - get/set methods
@end
