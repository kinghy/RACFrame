//
//  PayDissentViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "PayDissentViewController.h"
#import "DissentOrderEntity.h"

#define kTextViewPlaceHolder @"请描述遇到的问题，以便我们及时为您解决"
@interface PayDissentViewController ()<UITextViewDelegate,UITextFieldDelegate>{
    PayDetailViewModel* _viewModel;
    NSArray<RACTuple*> *_pointViewArray;
    
}
@property (nonatomic) NSInteger selectedIndex ;
@property (nonatomic) NSInteger tmpIndex ;
@end

@implementation PayDissentViewController

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
+(instancetype)controllerWithViewModel:(PayDetailViewModel*)viewModel{
    PayDissentViewController *c = [[self alloc] initWithNibName:[[self class] description] bundle:nil viewModel:viewModel];
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
    [super viewWillAppear: animated];
    [self navigationBarHidden:NO statusBarStyle:UIStatusBarStyleDefault title:@"异议申请"];
}

-(void)formatView{
    _selectedIndex = -1;
    _tmpIndex = -1;
    self.view.backgroundColor = kTableBgColor;
    [self.btnCommit setBackgroundColor:kBtnBlueColor];
    self.btnCommit.enabled = YES;
    [self.btnCommit cornerButton];
    
    //键盘区域外点击自动隐藏
    [self.view autoHideKeyBoard];
//

    self.btnCommit.rac_command = _viewModel.doDissentCommand;
    @weakify(self,_viewModel);
    
    [[self.btnCommit.rac_command.executionSignals flatten]subscribeNext:^(id x) {
        @strongify(self);
        if([x isKindOfClass:[DissentOrderEntity class]]){
            DissentOrderEntity* e = (DissentOrderEntity*)x;
            if ([e.result isEqualToString:@"Y"]) {
                [self.view makeToast:@"异议申请提交成功"];
                [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(gotoPayDetail) userInfo:nil repeats:NO];
            }
        }
    }];
    
    [self.btnCommit.rac_command.executing subscribeNext:^(id x) {
        @strongify(self);
        [x boolValue] ?[self.view showWaiting]:[self.view hideWaiting];
    }];
    
    [self.btnCommit.rac_command.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        NSString *errorMsg = error.userInfo[kErrorMsg];
        [self.view makeQuickToast:errorMsg];
        [self.view hideWaiting];
    }];
    
    self.tableViewFrame.hidden = YES;
    self.tableViewFrame.backgroundColor = kBgShadowColor;
    [self.dissentHiddenBtn addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    [self.btnComplete addTarget:self action:@selector(completedSelecteView) forControlEvents:UIControlEventTouchUpInside];
    [self.btnClose addTarget:self action:@selector(hideSelectView) forControlEvents:UIControlEventTouchUpInside];
    _pointViewArray = @[RACTuplePack(self.btnBuy,self.imageBuy,self.lblBuy),
                       RACTuplePack(self.btnSell,self.imageSell,self.lblSell),
                       RACTuplePack(self.btnProfit,self.imageProfit,self.lblProfit),
                       RACTuplePack(self.btnCheckOut,self.imageCheckOut,self.lblCheckOut),
                       RACTuplePack(self.btnTradeFee,self.imageTradeFee,self.lblTradeFee),
                       RACTuplePack(self.btnOther,self.imageOther,self.lblOther)];
    [_pointViewArray enumerateObjectsUsingBlock:^(RACTuple * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        RACTupleUnpack(UIButton *btn) = obj;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    RAC(self.pointLabel, text)= RACObserve(_viewModel,dissentPointStr);
    [self.btnSelectAntiPoint addTarget:self action:@selector(showSelectView) forControlEvents:UIControlEventTouchUpInside];
    
    self.textView.delegate = self;

    [self.textView autoAdjustCoveredWithDelegate:self];
    self.textView.text = kTextViewPlaceHolder;//初始化文字
    
    [[self rac_signalForSelector:@selector(textViewDidEndEditing:) fromProtocol:@protocol(UITextViewDelegate)] subscribeNext:^(id x) {
        @strongify(_viewModel)
        RACTupleUnpack(UITextView* textView) = x;
        _viewModel.dissentReasonText = textView.text;//监听了textViewDidBeginEditing之后textView.rac_textSignal将不再触发，所以在这里赋值
        if([textView.text isEqualToString:@""]){
            textView.text = kTextViewPlaceHolder;
        }
    }];
    [[self rac_signalForSelector:@selector(textViewDidBeginEditing:) fromProtocol:@protocol(UITextViewDelegate)] subscribeNext:^(id x) {
        RACTupleUnpack(UITextView* textView) = x;
        if([textView.text isEqualToString:kTextViewPlaceHolder]){
            textView.text = @"";
        }
    }];
    
    self.lblTradeID.text = _viewModel.pno;
    
    RAC(self.currentValue,text) = RACObserve(_viewModel, dissentCurrentValue);
    [RACObserve(_viewModel,dissentPoint) subscribeNext:^(NSString *str) {
        @strongify(self)
        if([str isEqualToString:kDissentPointInfoKey] || [str isEqualToString:kDissentPointBuyKey]
           || [str isEqualToString:kDissentPointSellKey]|| [str isEqualToString:kDissentPointWinKey]|| [str isEqualToString:kDissentPointLossKey]){
            self.myValueTextField.hidden = NO;
        }else{
            self.myValueTextField.hidden = YES;
        }
    }];
    self.myValueTextField.delegate =self;
    [self.myValueTextField numberFormatWithDelegate:self];//输入框只允许输入数字
//    提交地址和理由有问题
    RAC(_viewModel,dissentValue) = self.myValueTextField.rac_textSignal;
    

}

#pragma mark - public methods

#pragma mark - private methods
-(void)clickBtn:(UIButton *)button{
    @weakify(self)
    [_pointViewArray enumerateObjectsUsingBlock:^(RACTuple * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        RACTupleUnpack(UIButton *btn,UIImageView *img,UILabel *label) = obj;
        if ([btn isEqual:button]){
            img.hidden = NO;
            label.textColor = kTextThirdColor;
            [btn superview].backgroundColor = kTableBgColor;
            self.tmpIndex = idx;
        }else{
            img.hidden = YES;
            label.textColor = kTextGrayColor;
            [btn superview].backgroundColor = [UIColor whiteColor];
        }
    }];
}

-(void)completedSelecteView{
    if(_tmpIndex>=0){
        _selectedIndex = _tmpIndex;
        RACTupleUnpack(UIButton *btn,UIImageView *img,UILabel *label) = _pointViewArray[_selectedIndex];
        _viewModel.dissentPointStr = label.text;
    }
    _tmpIndex = -1;
    [self hideSelectView];
}

-(void)showSelectView{
    [self.view endEditing:YES];
    if(_selectedIndex>=0){
        RACTupleUnpack(UIButton *btn) = _pointViewArray[_selectedIndex];
        [self clickBtn:btn];
    }else{
        [self clickBtn:nil];
    }
    self.dissentBottomConstraint.constant = -500;
    self.tableViewFrame.hidden = NO;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.4f animations:^{
        self.dissentBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

-(void)hideSelectView{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.4f animations:^{
        self.dissentBottomConstraint.constant = -500;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.tableViewFrame.hidden = YES;
    }];
}

-(void)gotoPayDetail{
    [self.navigationController popViewControllerAnimated:YES];
    [_viewModel refresh];
}

#pragma mark - delegate methods

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if([string isEqualToString:@"5"]){
//        return NO;
//    }
//    return YES;
//}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length>150) {
        return NO;
    }
    return YES;
}

#pragma mark - Action methods

#pragma mark - get/set methods
@end

