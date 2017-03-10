//
//  PayDetailViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "PayDetailViewController.h"
#import "PayDetailSection.h"
#import "OrderDetailsEntity.h"
#import "PayDissentViewController.h"

@interface PayDetailViewController (){
    PayDetailViewModel* _viewModel;
}

@end

@implementation PayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.detailTable rftableWithController:self andNibArray:@[@"PayDetailSection"]];
    [self.detailTable addEntity:nil withSection:[PayDetailSection class]];
}

-(void)doBack:(id)sender{

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
+(instancetype)controllerWithViewModel:(PayDetailViewModel*)viewModel{
    PayDetailViewController *c = [[self alloc] initWithNibName:[[self class] description] bundle:nil viewModel:viewModel];
    return c;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil viewModel:(PayDetailViewModel*)viewModel{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        _viewModel = viewModel;
    }
    return self;
}
#pragma mark - extends methods


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:NO statusBarStyle:UIStatusBarStyleDefault title:@"详情"];
    [self.payBtn cornerButton];
}

-(void)bindViewModel{
    
    @weakify(self,_viewModel)
    [RACObserve(_viewModel, stateName) subscribeNext:^(id x) {
        @strongify(self)
        [self.payBtn setTitle:x?x:@"加载中" forState:UIControlStateNormal];
    }];
    
    [RACObserve(_viewModel, state) subscribeNext:^(id x) {
        @strongify(self)
        [self changePayBtn:x];
    }];
    
    self.payBtn.rac_command = _viewModel.doCommand;
    [self.payBtn.rac_command.executing subscribeNext:^(id x) {
        @strongify(self)
        [x boolValue] ?[self.view showWaiting]:[self.view hideWaiting];
    }];
    
    [[self.payBtn.rac_command.executionSignals flatten] subscribeNext:^(id x) {
        @strongify(self,_viewModel)
        if([x isEqualToString:kSettleDoPress]){
            [self.view makeQuickToast:@"你的催款通知已收到，我们将加快处理，感谢配合！"];
        }
        [_viewModel refresh];
    }];

}
#pragma mark - public methods

#pragma mark - private methods
-(void)changePayBtn:(NSString*)state{
    [self.payView setHidden:NO];
    if([state isEqualToString:kSettleDoPay]||[state isEqualToString:kSettleDoPress]){
        [self.payBtn setBackgroundColor:kBtnBlueColor];
        [self.payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.payBtn setUserInteractionEnabled:YES];
    }else if([state isEqualToString:kSettleCreateCheck]){
        //生成账单时通过修改约束隐藏按钮栏
        for(NSLayoutConstraint *layout in [self.payView constraints]){
            if([layout.identifier isEqualToString:@"PayBtnViewConstraint"]){
                [layout setConstant:0.f];
                break;
            }
        }
        [self.payView setHidden:YES];
    }else {
        [self.payBtn setBackgroundColor:kBtnDisabledColor];
        [self.payBtn setTitleColor:kBtnTextDisabledColor forState:UIControlStateNormal];
        [self.payBtn setUserInteractionEnabled:NO];
    }
}
-(void)refreshDetail{
    [_viewModel refresh];
}

-(NSString*)changeDesc:(NSString*)value{
    if([value isEqualToString:kSettleDoPress]){
        return @"预计合作回报将在15分钟内到账，请耐心等候！";
    }else if([value isEqualToString:kSettleDoPay]){
        return @"如未手动付款，则由系统于今日23时后自动付款！";
    }else{
        return @"";
    }
}

-(void)changeUserProfit:(NSString*)value andState:(NSString*)state andSection:(PayDetailSection*)s{
    if([state isEqualToString:kSettleCreateCheck]){
        s.userprofitView.backgroundColor = kFlatGrayColor;
        //        s.userprofitLabel.font = [UIFont systemFontOfSize:24];
        s.userprofitLabel.text = @"账单生成中";
        s.userprofitdescLabel.hidden = YES;
        s.profitwinImg.hidden = YES;
        s.profitloseImg.hidden = YES;
        s.profitwinLabel.textColor = kTextGrayColor;
        s.profitloseLabel.textColor = kTextGrayColor;
    }else{
        s.userprofitView.backgroundColor = [AppUtil colorWithProfit:[value floatValue]];
        s.userprofitLabel.text = value?[AppUtil moneyFloatFormat:[value floatValue]]:@"— —";
        s.userprofitdescLabel.hidden = NO;
        s.userprofitdescLabel.text = value?([value floatValue]<0?@"合作赔付(元)":@"合作回报(元)"):@"— —";
        s.profitwinImg.hidden = !value||[value floatValue]<0;
        s.profitloseImg.hidden = !value||[value floatValue]>=0;
        s.profitwinLabel.textColor = (!value||[value floatValue]<0)?kTextGrayColor:kUpRedColor;
        s.profitloseLabel.textColor = (!value||[value floatValue]>=0)?kTextGrayColor:kDownGreenColor;
    }
}

-(void)gotoDissent{
    PayDissentViewController *controller = [PayDissentViewController controllerWithViewModel:_viewModel];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)gotDetail{
//    ExcuteNoReportViewController *controller = [ExcuteNoReportViewController controllerWithId:_viewModel.pID andType:_viewModel.pType andCode:self.stockCode];
//    [self.controller.navigationController pushViewController:controller animated:YES];
}
#pragma mark - delegate methods
-(void)rftable:(UITableView *)table willLoadSection:(UIView *)section entity:(id)entity{
    if([section isKindOfClass:[PayDetailSection class]]){
        @weakify(self)
        PayDetailSection *s = (PayDetailSection*)section;
        
        RAC(s.stockLabel,text) = [RACSignal zip:@[RACObserve(_viewModel, stockName),RACObserve(_viewModel, stockCode)] reduce:^id(NSString* name,NSString* code){
            @strongify(self)
            return (name||code)?[NSString stringWithFormat:@"%@%@",name?name:@"— —",code?code:@"— —"]:@"— —";
        }];
        RACSignal *userprofitSignal = [RACSignal combineLatest:@[RACObserve(_viewModel, userProfit),RACObserve(_viewModel, state)]];
        
        [userprofitSignal subscribeNext:^(id x) {
            @strongify(self)
            RACTupleUnpack(NSString *value,NSString *state) = x;
            [self changeUserProfit:value andState:state andSection:s];
        }];
        
        RAC(s.limitLabel,text,@"— —") = RACObserve(_viewModel, limit);
        RAC(s.buywayLabel,text,@"— —") = RACObserve(_viewModel, buyWay);
        
        RAC(s.amountLabel,text) = [RACObserve(_viewModel, amount) map:^id(id value){
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
            formatter.numberStyle = NSNumberFormatterDecimalStyle;
            return value?[formatter stringFromNumber:[NSNumber numberWithInteger:[value floatValue]*100]]:@"— —";
        }];
        
        RAC(s.fundLabel,text) = [RACObserve(_viewModel, fund) map:^id(id value){
            return value?[AppUtil moneyStringFormat:value]:@"— —";
        }];
        
        RAC(s.sellfundLabel,text) = [RACObserve(_viewModel, sellFund) map:^id(id value){
            return value?[AppUtil moneyStringFormat:value]:@"— —";
        }];
        
        RAC(s.profitLabel,text) = [RACObserve(_viewModel, profit) map:^id(id value){
            return value?[NSString stringWithFormat:@"%@",[AppUtil moneyFloatFormat:[value floatValue]]]:@"— —";
        }];
        
        RAC(s.profitLabel,textColor) = [RACObserve(_viewModel, profit) map:^id(id value){
            if(value){
                return [value floatValue]<0?kDownGreenColor:kUpRedColor;
            }else{
                return kTextGrayColor;
            }
        }];
        
        RAC(s.profitloseLabel,text) = [RACObserve(_viewModel, stopLossPoint) map:^id(NSString* value) {
            return value?[NSString stringWithFormat:@"%.f%% 以内亏损",value.floatValue*100]:@"— —";
        }];
        RAC(s.profitwinLabel,text) = [RACObserve(_viewModel, winProfitRate) map:^id(NSString* value) {
            return value?[NSString stringWithFormat:@"%.f%% 盈利",value.floatValue*100]:@"— —";
        }];
        
        
        RAC(s.descLabel,text) = [RACObserve(_viewModel, state) map:^id(id value) {
            @strongify(self)
            return [self changeDesc:value];
        }];
        
        RAC(s.dissentLabel,text) = RACObserve(_viewModel, dissentTime);
        
        s.dissentBtn.rac_command = _viewModel.dissentCommand;
        [[s.dissentBtn.rac_command.executionSignals flatten] subscribeNext:^(id x) {
            @strongify(self);
            [self gotoDissent];
        }];
        [s.dissentBtn.rac_command.errors subscribeNext:^(id x) {
            @strongify(self);
            NSError* error = (NSError*)x;
            NSString *errorMsg = error.userInfo[kErrorMsg];
            [self.view makeQuickToast:errorMsg];
        }];
        
        [s.detailBtn addTarget:self action:@selector(gotDetail) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Action methods

#pragma mark - get/set methods
@end
