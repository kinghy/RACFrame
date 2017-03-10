//
//  PayViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/15.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "PayViewController.h"
#import "PaySection.h"
#import "PayViewModel.h"
#import "RFSectionBox.h"
#import "SettlementsEntity.h"
#import "PayDetailViewModel.h"
#import "PayDetailViewController.h"

@interface PayViewController ()<RFTableDelegate,RFRefreshDelegate>{
    
    
}
@property (strong, nonatomic) PayViewModel *viewModel;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.payTableView.backgroundColor = kTableBgColor;
    [self.payTableView rftableWithController:self andNibArray:@[@"PaySection"]];
    [self.payTableView rfrefreshWithController:self andObject:_viewModel];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - init methods
+(instancetype)controllerWithViewModel:(PayViewModel*)viewModel{
    PayViewController *c = [[self alloc] initWithNibName:[[self class] description] bundle:nil viewModel:viewModel];
    return c;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(PayViewModel*)viewModel{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        _viewModel = viewModel;
    }
    return self;
}

#pragma mark - extends methods

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:NO statusBarStyle:UIStatusBarStyleDefault title:@"收付款"];
    [self loadNewData];
    [self.view showWaiting];
}
#pragma mark - public methods

#pragma mark - private methods
-(void)loadNewData{
    @weakify(self);
    [[_viewModel renewPayList] subscribeNext:^(id x) {
        @strongify(self);
        RACTupleUnpack(NSArray<SettlementsRecordsEntity*> *allArray,NSArray<SettlementsRecordsEntity*> *newArray) = x;//第一个存放所有元素，第二个存放新增元素
        [self.payTableView removeAllEntities];
        [self.payTableView addEntities:newArray withSection:[PaySection class]];
        [self.payTableView reloadData];
    }error:^(NSError *error) {
        @strongify(self);
        [self.payTableView endHeaderRefreshing];
        [self.view hideWaiting];

    } completed:^{
        @strongify(self);
        [self.payTableView endHeaderRefreshing];
        [self.view hideWaiting];
    }];
}

-(void)loadNextData{
    @weakify(self);
    [[_viewModel refreshPayList] subscribeNext:^(id x) {
        @strongify(self);
        RACTupleUnpack(NSArray<SettlementsRecordsEntity*> *allArray,NSArray<SettlementsRecordsEntity*> *newArray) = x;//第一个存放所有元素，第二个存放新增元素
        if(newArray.count>0){
            [self.payTableView addEntities:newArray withSection:[PaySection class]];
            [self.payTableView reloadData];
            [self.payTableView endFooterRefreshingWithNoMoreData:NO];
        }else{
            [self.payTableView endFooterRefreshingWithNoMoreData:YES];
        }
    }error:^(NSError *error) {
        @strongify(self);
        [self.payTableView.mj_footer endRefreshing];
    } completed:^{
        @strongify(self);
        [self.payTableView endHeaderRefreshing];
    }];
}
#pragma mark - delegate methods
-(void)rftable:(UITableView *)table forSection:(UIView *)section entity:(id)entity{
    if([section isKindOfClass:[PaySection class]]){
        SettlementsRecordsEntity* e = (SettlementsRecordsEntity*)entity;
        PaySection *s = (PaySection*)section;
        
        //格式化创建时间
        NSDateFormatter *f = [NSDateFormatter new];
        [f setDateFormat:@"MM月dd日"];
        s.createtimeLabel.text= [NSString stringWithFormat:@"%@创建",[f stringFromDate:[NSDate dateWithTimeIntervalSince1970:[e.create_time integerValue]]]];
        
        if([e.state isEqualToString:kSettleDoPress] || [e.state isEqualToString:kSettleDoPay]){
            s.statusLabel.hidden = YES;
            s.doBtn.hidden = NO;
            @weakify(self,s)
            s.doBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self)
                return [self.viewModel doSettleWithId:e.ID andType:e.p_type];
            }];
            [[s.doBtn.rac_command.executionSignals flatten] subscribeNext:^(id x) {
                @strongify(self,s)
                if([e.state isEqualToString:kSettleDoPress]){
                    [self.view makeQuickToast:@"你的催款通知已收到，我们将加快处理，感谢配合"];
                }else if([e.state isEqualToString:kSettleDoPay]){
                    s.statusLabel.hidden = NO;
                    s.statusLabel.text= kSettleDoSettlingStr;
                    s.doBtn.hidden = YES;
                }
            }];
            [s.doBtn setTitle:e.state_name forState:UIControlStateNormal];
        }else{
            s.statusLabel.hidden = NO;
            s.statusLabel.text= e.state_name;
            s.doBtn.hidden = YES;
        }

        s.stoceknameLabel.text = e.stock_name;
        
        [s.limitImg setImage:[e.sub_type isEqualToString:@"0"]?[UIImage imageNamed:@"icon_t1"]:[UIImage imageNamed:@"icon_t5"]];
        s.amountLabel.text = [NSString stringWithFormat:@"%ld股",[e.amount integerValue]*100];
        s.totalLabel.text = [NSString stringWithFormat:@"%.2f万元",[e.fund floatValue]/10000.f];
        s.profitLabel.text = e.profit?[NSString stringWithFormat:@"%.2f",[e.profit floatValue]]:@"— —";
        float up = [e.user_profit floatValue];
        s.resultLabel.text = e.user_profit?[NSString stringWithFormat:@"%.2f",up]:@"— —";
        s.resultLabel.textColor = (up>=0)?kUpRedColor:kDownGreenColor;
        s.resultdescLabel.text = (up>=0)?@"合作回报":@"合作赔付";
    }
}

-(void)rftable:(UITableView *)table selectedSection:(UIView *)section entity:(id)entity{
    SettlementsRecordsEntity* e = (SettlementsRecordsEntity*)entity;
    PayDetailViewModel *model = [PayDetailViewModel viewModelWithPid:e.p_id andPType:e.p_type];
    PayDetailViewController *c = [PayDetailViewController controllerWithViewModel:model];
    
    [self.navigationController.navigationController pushViewController:c animated:YES];
}


-(void)refresh:(UIScrollView *)view headerBeginRefreshing:(MJRefreshComponent *)refreshView withObject:(NSObject *)obj{
    [self loadNewData];
}

-(void)refresh:(UIScrollView *)view footerBeginRefreshing:(MJRefreshComponent *)refreshView withObject:(NSObject *)ob{
    [self loadNextData];
}
#pragma mark - Action methods

@end
