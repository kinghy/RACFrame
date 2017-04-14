//
//  MyStrategyViewController.m
//  RACTest
//
//  Created by  rjt on 17/3/2.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "MyStrategyViewController.h"
#import "MyStrategyViewModel.h"
#import "MyStrategySection.h"
#import "EmptyListSection.h"
#import "MyAllListEntity.h"
#import "ProfitsEntity.h"

@interface MyStrategyViewController ()<UIScrollViewDelegate,RFTableDelegate,RFRefreshDelegate>{
    int _tab;
}

@property (strong,nonatomic) NSArray<RACTuple*>* btnArray;
@property (strong,nonatomic) UIView* lineView;
@end

@implementation MyStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


//    @weakify(self)
//    RACSignal *refreshSignal = [appearSignal flattenMap:^RACStream *(id value) {
//        @strongify(self);
//        [self.view showWaiting];
//        return [self.viewModel renewList];
//    }];
//    
//    [[self rac_signalForSelector:@selector(hide)] subscribeNext:^(id x) {
//        @strongify(self);
//        [self.viewModel clearList];
//    }];
//    

//    
//    [RACObserve(_viewModel,refreshFlg) subscribeNext:^(id x) {
//        @strongify(self);
//        [self.pAdaptor notifyChanged];
//    }];

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
    [self navigationBarHidden:NO statusBarStyle:UIStatusBarStyleDefault title:@"我的策略"];
}

-(void)formatView{
    self.allModel = [MyStrategyViewModel viewModelWithType:kMyStrategyAll];
    self.todayModel = [MyStrategyViewModel viewModelWithType:kMyStrategyToday];
    self.notlastModel = [MyStrategyViewModel viewModelWithType:kMyStrategyNotLast];
    self.lastModel = [MyStrategyViewModel viewModelWithType:kMyStrategyLast];
    self.sellModel = [MyStrategyViewModel viewModelWithType:kMyStrategySell];
    [self.allTable rftableWithController:self andNibArray:@[@"MyStrategySection",@"EmptyListSection"]];
    self.allTable.backgroundColor = kTableBgColor;
    [self.allTable rfrefreshWithController:self andObject:_allModel];
    [self.todayTable rftableWithController:self andNibArray:@[@"MyStrategySection",@"EmptyListSection"]];
    self.todayTable.backgroundColor = kTableBgColor;
    [self.todayTable rfrefreshWithController:self andObject:_todayModel];
    [self.notlastTable rftableWithController:self andNibArray:@[@"MyStrategySection",@"EmptyListSection"]];
    self.notlastTable.backgroundColor = kTableBgColor;
    [self.notlastTable rfrefreshWithController:self andObject:_notlastModel];
    [self.lastTable rftableWithController:self andNibArray:@[@"MyStrategySection",@"EmptyListSection"]];
    self.lastTable.backgroundColor = kTableBgColor;
    [self.lastTable rfrefreshWithController:self andObject:_lastModel];
    [self.sellTable rftableWithController:self andNibArray:@[@"MyStrategySection",@"EmptyListSection"]];
    self.sellTable.backgroundColor = kTableBgColor;
    [self.sellTable rfrefreshWithController:self andObject:_sellModel];
    
    self.scrollView.showsHorizontalScrollIndicator = NO; //不显示水平滑动线
    self.scrollView.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
    //    self.scrollView.pagingEnabled=YES;//scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
    self.scrollView.delegate = self;
    [self loadBtn];
    @weakify(self)
    [self.btnArray.rac_sequence.signal subscribeNext:^(id x) {
        RACTupleUnpack(UIButton* curBtn,UITableView* curTable,MyStrategyViewModel* model) = x;
        @strongify(self)
        @weakify(curTable)
        [model.dataSource.errorsSignal subscribeNext:^(NSError* error) {
            @strongify(self,curTable)
            [self.view makeQuickToast:error.userInfo[kErrorMsg]];
            [curTable endHeaderRefreshing];
            [curTable endFooterRefreshingWithNoMoreData:NO];
            [self.view hideWaiting];
        }];
        [curTable bindDataSource:model.dataSource.recordsSignal withSection:[MyStrategySection class] andEmptySection:[EmptyListSection class]];
        [model.dataSource.recordsSignal subscribeNext:^(id x) {
             @strongify(self,curTable)
            [curTable endHeaderRefreshing];
            [curTable endFooterRefreshingWithNoMoreData:NO];
            [self.view hideWaiting];
        }];
    }];
    
}

-(void)bindViewModel{

}
#pragma mark - public methods

#pragma mark - private methods
-(void)loadNewData:(MyStrategyViewModel*)model andTable:(UITableView*)table{
    [model renew];
}

-(void)loadNextData:(MyStrategyViewModel*)model andTable:(UITableView*)table{
    [model turning];
}
//创建按钮
-(void)loadBtn{
    ;
    NSArray *tmp = @[RACTuplePack(@"全部",_allTable,_allModel),RACTuplePack(@"今日创建",_todayTable,_todayModel),RACTuplePack(@"最后持仓日",_lastTable,_lastModel),RACTuplePack(@"非最后持仓日",_notlastTable,_notlastModel),RACTuplePack(@"已平仓",_sellTable,_sellModel)];
    RACSignal *signal = [tmp.rac_sequence.signal scanWithStart:nil reduceWithIndex:^id(id running, id next, NSUInteger index) {
        UIButton* btn = [[UIButton alloc] init];
        int x = 35;
        if(running){
            RACTupleUnpack(UIButton *btn)= running;
            x += btn.frame.origin.x+btn.frame.size.width;
        }
        //动态计算宽度
        CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
        //        btn.titleLabel.textColor = kTitleColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        RACTupleUnpack(NSString *title,UITableView *tabel,MyStrategyViewModel* model) = next;
        CGSize btnSize = [title boundingRectWithSize:size
                                             options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                          attributes:@{ NSFontAttributeName:btn.titleLabel.font}
                                             context:nil].size;
        [btn setTitle:title forState:UIControlStateNormal];
        //        [btn setTitleColor:kTitleColor forState:UIControlStateNormal];
        btn.frame = CGRectMake(x, 0, btnSize.width,29);//留1个DP放指示线
        btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        return RACTuplePack(btn,tabel,model);
    }];
    _btnArray = [signal toArray];
    RACSignal *btnSingal = _btnArray.rac_sequence.signal;
    //按钮添加至scrollview
    [btnSingal subscribeNext:^(RACTuple *x) {
        RACTupleUnpack(UIButton *btn)= x;
        [self.scrollView addSubview:btn];
        [btn setTitleColor:kTextMainColor forState:UIControlStateNormal];
        CGRect r = self.scrollView.bounds ;
        r.size.width = btn.frame.origin.x + btn.frame.size.width +35;
        self.scrollView.contentSize = r.size;
    }];
    
    @weakify(self)
    [[btnSingal flattenMap:^RACStream *(RACTuple *x) {
        RACTupleUnpack(UIButton *btn)= x;
        __weak RACTuple *_x = x;
        return [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] map:^id(id value) {
            return _x;
        }];
    }] subscribeNext:^(RACTuple* t) {
        @strongify(self)
        [self clickBtn:t];
    }];
    
    //生成指示线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = kBtnBlueColor;
    [self.scrollView addSubview:self.lineView];
    [self clickBtn:_btnArray[_tab]];//初始化选中
}
#pragma mark - delegate methods
-(void)refresh:(UIScrollView *)view headerBeginRefreshing:(MJRefreshComponent *)refreshView withObject:(NSObject *)obj{
    MyStrategyViewModel *model= (MyStrategyViewModel*)obj;
    [self loadNewData:model andTable:(UITableView*)view];
}

-(void)refresh:(UIScrollView *)view footerBeginRefreshing:(MJRefreshComponent *)refreshView withObject:(NSObject *)obj{
    MyStrategyViewModel *model= (MyStrategyViewModel*)obj;
    [self loadNextData:model andTable:(UITableView*)view];
    
}
-(void)rftable:(UITableView *)table forSection:(UIView *)section entity:(id)entity{
    if([section isKindOfClass:[EmptyListSection class]]) {
        
        EmptyListSection *s = (EmptyListSection *)section;
        
        if(table == _allTable || table == _todayTable){
            s.titleLabel.text = @"暂无策略合作";
            s.publishBtn.hidden = NO;
        }else if(table == _lastTable){
            s.titleLabel.text = @"暂无最后持仓日策略";
            s.publishBtn.hidden = YES;
        }else if(table == _notlastTable){
            s.titleLabel.text = @"暂无非最后持仓日策略";
            s.publishBtn.hidden = YES;
        }else if(table == _sellTable){
            s.titleLabel.text = @"暂无已平仓策略";
            s.publishBtn.hidden = YES;
        }
    }
    
    if([section isMemberOfClass:[MyStrategySection class]]){
        MyStrategySection *s = (MyStrategySection*)section;
        MyAllListRecordsEntity *e = (MyAllListRecordsEntity*)entity;
        s.stocknameLabel.text = e.stock_name;
        s.amountLabel.text = [NSString stringWithFormat:@"%ld股",[e.amount integerValue]*100];
        s.fundLabel.text = [NSString stringWithFormat:@"%.2f万元",[e.fund floatValue]/10000];
        s.createLabel.text = e.tips1;
        s.deadLabel.text = e.tips2;
        if([e.tipscolor isEqualToString:@"1"]){
            s.deadLabel.textColor = kLastOrangeColor;
        }else if([e.tipscolor isEqualToString:@"2"]){
            s.deadLabel.textColor = kTextGrayColor;
        }else if([e.tipscolor isEqualToString:@"3"]){
            s.deadLabel.textColor = kTextMainColor;
        }
        [s.limitImg setImage:[e.sub_type isEqualToString:@"0"]?[UIImage imageNamed:@"icon_t1"]:[UIImage imageNamed:@"icon_t5"]];
        s.investLabel.text = [NSString stringWithFormat:@" %@（股东号后四位%@）",e.invester_name,e.invest_account];
        if(e.state.integerValue<200){
            CGRect rect = s.frame;
            rect.size.height = 115;
            s.frame = rect;
            s.investerView.hidden = YES;
        }else{
            CGRect rect = s.frame;
            rect.size.height = 135;
            s.frame = rect;
            s.investerView.hidden = NO;
        }
        if (e.profitEntity ) {
            if (e.profitEntity.state.intValue >= 500) {//已平仓
                CGRect rect = s.frame;
                rect.size.height = 135;
                s.frame = rect;
                s.investerView.hidden = NO;
                
                s.nowpriceLabel.text = [NSString stringWithFormat:@"%.2f", e.profitEntity.sell_deal_price_avg.doubleValue];
                //18卖出
                s.priceLabel.text = @"卖出价格";
                //待添加
                s.profitLabel.text = [NSString stringWithFormat:@"%.2f", e.profitEntity.profit.doubleValue];
                s.rateLabel.text = e.profitEntity.profit.floatValue >= 0?@"盈利":@"亏损";
                s.profitLabel.textColor = [AppUtil colorWithProfit:e.profitEntity.profit.doubleValue];
                s.rateLabel.textColor = [AppUtil colorWithProfit:e.profitEntity.profit.doubleValue];
            }
            else if (e.profitEntity.state.intValue < 500) {//待平仓
                CGRect rect = s.frame;
                rect.size.height = 135;
                s.frame = rect;
                s.investerView.hidden = NO;
                s.nowpriceLabel.textColor = kTextMainColor;
                s.nowpriceLabel.text = [NSString stringWithFormat:@"%.2f", e.profitEntity.cur_price.doubleValue];
                s.profitLabel.text = [NSString stringWithFormat:@"%.2f", e.profitEntity.profit.doubleValue];
                s.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", e.profitEntity.profit_rate.doubleValue * 100];
                s.profitLabel.textColor = [AppUtil colorWithProfit:e.profitEntity.profit.doubleValue];
                s.rateLabel.textColor = [AppUtil colorWithProfit:e.profitEntity.profit.doubleValue];
                
                if ([e.profitEntity.state isEqualToString:@"201"]) {//T日
                    s.priceLabel.text = [NSString stringWithFormat:@"%.2f买入", e.profitEntity.buy_deal_price_avg.doubleValue];
                }else{
                    if (e.profitEntity.profit.intValue >= 0) {//盈利
                        s.priceLabel.text = [NSString stringWithFormat:@"%.2f止盈", e.profitEntity.sell_win_price.doubleValue];
                    }else{//亏损
                        s.priceLabel.text = [NSString stringWithFormat:@"%.2f止损", e.profitEntity.sell_loss_price.doubleValue];
                    }
                }
            }
        }else{
            s.nowpriceLabel.text = @"— —";
            s.profitLabel.text = @"— —";
            s.rateLabel.text = @"— —";
            s.priceLabel.text = @"— —";
            UIColor *textColor = kTextGrayColor;
            s.nowpriceLabel.textColor = textColor;
            s.profitLabel.textColor = textColor;
            s.rateLabel.textColor = textColor;
            s.priceLabel.textColor = textColor;
        }
    }
}
#pragma mark - Action methods

#pragma mark - get/set methods
-(void)clickBtn:(RACTuple*)cur {
    RACTupleUnpack(UIButton* curBtn,UITableView* curTable,MyStrategyViewModel* model) = cur;
    [self hideTables];
    [curBtn setTitleColor:kBtnBlueColor forState:UIControlStateNormal];
    CGRect rect = CGRectMake(curBtn.frame.origin.x-5, curBtn.frame.size.height, curBtn.frame.size.width+10, 1);//新的位置
    [self showTable:curTable withModel:model];
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.3f];
    self.lineView.frame = rect;
    [UIView commitAnimations];
    
}

-(void)showTable:(UITableView*)curTable withModel:(MyStrategyViewModel*) model{
    curTable.hidden = NO;
    [self.view showWaiting];
    [self loadNewData:model andTable:curTable];
}

-(void)hideTables{
    for(RACTuple* t in _btnArray){
        RACTupleUnpack(UIButton* btn,UITableView* table) = t;
        [btn setTitleColor:kTextMainColor forState:UIControlStateNormal];
        table.hidden = YES;
    }
}
@end
