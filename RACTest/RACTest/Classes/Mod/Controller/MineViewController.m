//
//  MineViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/24.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "MineViewController.h"
#import "UserViewModel.h"
#import "SetEntity.h"
#import "SetSection.h"
#import "MyStrategyViewController.h"

@interface MineViewController ()<RFTableDelegate>
@property (strong,nonatomic) UserViewModel *user;

@property (strong, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIButton *iconView;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UIView *levelView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mineLimitHeight;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet UILabel *lbName;

@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *limit5Label;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITableView *table;

- (IBAction)goBack:(id)sender;
- (IBAction)limit0Clicked:(id)sender;
- (IBAction)limit5Clicked:(id)sender;
@end

@implementation MineViewController

- (void)viewDidLoad {
    _user = [UserViewModel sharedInstance];
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshSet) name:kLoginSuccessed object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordWindosHide) name:kPasswordWindowHide object:nil];
//    // Do any additional setup after loading the view from its nib.
//
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshListStatus) name:kDockChange object:nil];
//
//    [self.loginBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
//
//    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginClicked)];
//    [self.loginView addGestureRecognizer:gest];
//
//    self.url=[NSString stringWithFormat:@"%@%@%@",[ConfigManager shareConfigManager].customerServiceAddress,[[UserInfoManager shareUserInfoManager] getSessionID],@"&type=1"];
//    [self getCustomerServiceInfo];
    
    
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
-(void)formatView{
    self.table.backgroundColor = kTableBgColor;
    [self.table rftableWithController:self andNibArray:@[@"SetSection"]];
}

-(void)bindViewModel{
    [self.iconView setBackgroundImage:[UIImage imageNamed:@"head-login.png"] forState:UIControlStateNormal];
    #warning 头像加载暂时去除
    //    [[UserInfoManager shareUserInfoManager] getHeadImgForBtn:self.titleImgView];
    [self.iconView circleWithBorderColor:kLoginHeadBG andWidth:2];
    RAC(self.lbName,text) = RACObserve(_user, nick_name);
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:YES statusBarStyle:UIStatusBarStyleLightContent title:@"我的"];
    [self refreshList];
}
#pragma mark - public methods

#pragma mark - private methods


-(void)refreshList{
    if([_user hasLogin]){
        self.mineLimitHeight.constant = 76;
        self.loginView.userInteractionEnabled = NO;
        self.loginBtn.hidden = YES;
        self.userInfoView.hidden = NO;
        
        SetEntity *e1 = [SetEntity new];
        e1.title = @"我的策略";
        e1.titleImg = @"user_tactic";
        e1.tag = 11;
        e1.bottomLineShow = YES;
        e1.bottomLineIndent = 15;
        [self.table addEntity:e1 withSection:[SetSection class]];
        SetEntity *e2 = [SetEntity new];
        e2.title = @"异议/ 补偿";
        e2.titleImg = @"user_contract";
        e2.tag = 4;
        e2.bottomLineShow = YES;
        e2.bottomLineIndent = 0;
        [self.table addEntity:e2 withSection:[SetSection class]];
        
        [self.table addSplitWithColor:kTableBgColor];

        SetEntity* e3 = [SetEntity new];
        e3.title = @"操盘宝";
        e3.desc = @"--";
        e3.titleImg = @"user_cpb";
        e3.tag = 5;
        e3.bottomLineShow = YES;
        e3.bottomLineIndent = 0;
        [self.table addEntity:e3 withSection:[SetSection class]];
        
        [self.table addSplitWithColor:kTableBgColor];

        SetEntity* e4 = [SetEntity new];
        e4.title = @"认证等级";
        e4.titleImg = @"user_auth";
        e4.tag = 999;
        e4.desc = @"--";
        e4.bottomLineShow = YES;
        e4.bottomLineIndent = 0;
        [self.table addEntity:e4 withSection:[SetSection class]];
        
        [self.table addSplitWithColor:kTableBgColor];
        
        SetEntity* e5 = [SetEntity new];
        e5.title = @"@私信";
        e5.titleImg = @"user_message";
        e5.desc = @"";
#warning 红点
//        e5.showAlertImg=NO;
        e5.tag = 7;
        e5.bottomLineShow = YES;
        e5.bottomLineIndent = 15;
        [self.table addEntity:e5 withSection:[SetSection class]];
        SetEntity* e6 = [SetEntity new];
        e6.title = @"我的客服";
        e6.titleImg = @"user_service";
        e6.tag = 8;
        e6.bottomLineShow = YES;
        e6.bottomLineIndent = 15;
        [self.table addEntity:e6 withSection:[SetSection class]];
        SetEntity* e7 = [SetEntity new];
        e7.title = @"微信公众号";
        e7.titleImg = @"wechat";
        e7.tag = 6;
        e7.bottomLineShow = YES;
        e7.bottomLineIndent = 15;
        [self.table addEntity:e7 withSection:[SetSection class]];
        SetEntity* e8 = [SetEntity new];
        e8.title = @"设置";
        e8.titleImg = @"user_setting";
        e8.tag = 10;
        e8.bottomLineShow = YES;
        e8.bottomLineIndent = 0;
        [self.table addEntity:e8 withSection:[SetSection class]];
        
        SetEntity* e66 = [SetEntity new];
        e66.title = @"我的客服";
        e66.titleImg = @"user_service";
        e66.tag = 8;
        e66.bottomLineShow = YES;
        e66.bottomLineIndent = 15;
        [self.table addEntity:e66 withSection:[SetSection class]];
        SetEntity* e77 = [SetEntity new];
        e77.title = @"微信公众号";
        e77.titleImg = @"wechat";
        e77.tag = 6;
        e77.bottomLineShow = YES;
        e77.bottomLineIndent = 15;
        [self.table addEntity:e77 withSection:[SetSection class]];
        SetEntity* e88 = [SetEntity new];
        e88.title = @"设置";
        e88.titleImg = @"user_setting";
        e88.tag = 10;
        e88.bottomLineShow = YES;
        e88.bottomLineIndent = 0;
        [self.table addEntity:e88 withSection:[SetSection class]];
        
    }else{
        self.loginView.userInteractionEnabled = YES;
        self.mineLimitHeight.constant = 0;
        self.loginBtn.hidden = NO;
        self.userInfoView.hidden = YES;
    }
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)limit0Clicked:(id)sender {
//    MyWebViewController* controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url = [NSString stringWithFormat:@"%@/riskcontrol/quota/index?type=0&session_id=%@",[ConfigManager shareConfigManager].h5Url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    controller.title = @"T+1额度";
//    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)limit5Clicked:(id)sender {
//    MyWebViewController* controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url = [NSString stringWithFormat:@"%@/riskcontrol/quota/index?type=5&session_id=%@",[ConfigManager shareConfigManager].h5Url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    controller.title = @"T+5额度";
//    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark - delegate methods
-(void)rftable:(UITableView *)table forSection:(UIView *)section entity:(id)entity{
    if([section isKindOfClass:[SetSection class]]){
        SetSection *s = (SetSection*)section;
        SetEntity *e = (SetEntity*)entity;
        s.titleImg.image = [UIImage imageNamed:e.titleImg];
        s.titleLabel.text = e.title;
        s.bottomLineView.hidden = !e.bottomLineShow;
        s.bottomLineIndent = e.bottomLineIndent;
        s.topLineView.hidden = !e.topLineShow;
        s.topLineIndent = e.topLineIndent;
        s.descLabel.text = e.desc;
    }
}

-(void)rftable:(UITableView *)table selectedSection:(UIView *)section entity:(id)entity{
    if([entity isKindOfClass:[SetEntity class]]){
        SetEntity *e = (SetEntity*)entity;
        if(e.tag == 11){
            MyStrategyViewController* c = [[MyStrategyViewController alloc] initWithNibName:@"MyStrategyViewController" bundle:nil];
            [self.navigationController pushViewController:c animated:YES];
        }
    }
}
#pragma mark - Action methods

#pragma mark - get/set methods
@end

//
//-(void)getCustomerServiceInfo{
//    
//    UserInfoManager *manager=[UserInfoManager shareUserInfoManager];
//    DEFINED_WEAK_SELF
//    [manager getCustomerServiceInfoWithReturnBlock:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
//        if ([entity isKindOfClass:[CustomerServiceEntity class]]) {
//            
//            CustomerServiceEntity *e=(CustomerServiceEntity *)entity;
//            _self.url=e.url;
//        }
//    }];
//    
//}
//
//
//-(void)loginClicked{
//    
//    [[PasswordWindow shareWindow] showWithLogin];
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    // 显示导航条
//    [[self navigationController] setNavigationBarHidden:YES animated:NO];
//    [self.pAdaptor.pSources clear];
//    
//    if (![UserInfoManager hasLogin]&&[UserInfoManager shareUserInfoManager].getUserID) {
//        [[PasswordWindow shareWindow] showWithLogin];
//    }
//    [self initQuickUI];
//    [self changeListState];
//    [self userLoad];
//    
//    if ([UserInfoManager hasLogin]) {
//        [self checkDockState];
//    }
//}
//
//-(void)passwordWindosHide{
//    if (![UserInfoManager hasLogin]&&[UserInfoManager shareUserInfoManager].getUserID) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }
//}
//
//
//-(void)refreshListStatus{
//    [self refreshListStatus:[InfomationManager shareInfomationManager].dockEntity];
//}
//
//
//-(void)checkDockState{
//    
//    DEFINED_WEAK_SELF
//    
//    if ([UserInfoManager hasLogin]) {
//        
//        
//        NSString *key = @"msg_reset_time";
//        NSString *from_time=[[NSUserDefaults standardUserDefaults]objectForKey:key];
//        
//        [[InfomationManager shareInfomationManager] checkDockStateByUpdateTime:from_time type:@"msg" block:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
//            if ([entity isKindOfClass:[NeedNoticecntEntity class]]) {
//                [_self refreshListStatus:(NeedNoticecntEntity*)new];
//                
//            }
//        }];
//        
//    }
//    
//    
//}
//
//
//
//
//-(void)refreshListStatus:(NeedNoticecntEntity*)dockEntity{
//    SetEntity* e = (SetEntity*)[self.pAdaptor.pSources entityWithTag:7];
//    if ([[dockEntity.records objectForKey:@"msg"]intValue]>0) {
//        e.showAlertImg=YES;
//    }
//    e = (SetEntity*)[self.pAdaptor.pSources entityWithTag:9];
//    if ([[dockEntity.records objectForKey:@"agreement"]intValue]>0) {
//        e.showAlertImg=YES;
//    }
//    
//    [self.pAdaptor notifyChanged];
//}
//

//
//
//-(void)refreshSet{
//    [self initQuickUI];
//    [self changeListState];
//    [self userLoad];
//    [self checkDockState];
//}
//
//-(void)initQuickUI{

//    
//    if ([UserInfoManager hasLogin]) {


//    }else{
//        SetEntity* entity1 = [SetEntity new];
//        entity1.title = @"新手引导";
//        entity1.tag = 1;
//        entity1.selectionStyle = UITableViewCellSelectionStyleGray;
//        entity1.lineBottomColor = kCellLineColor;
//        entity1.pIndentBottomLevel = 1;
//        entity1.selectedBgColor = QU_FLAT_COLOR_CELL_BG_SELECTED;
//        [self.pAdaptor.pSources addEntity:entity1 withSection:[SetSimpleListSection class]];
//        
//        SetEntity* entity2 = [SetEntity new];
//        entity2.title = @"常见问题";
//        entity2.tag = 2;
//        entity2.selectionStyle = UITableViewCellSelectionStyleGray;
//        //        entity2.lineBottomColor = kCellLineColor;
//        entity2.selectedBgColor = QU_FLAT_COLOR_CELL_BG_SELECTED;
//        [self.pAdaptor.pSources addEntity:entity2 withSection:[SetSimpleListSection class]];
//        empty = [QUEntity entityWithLineTop:kCellLineColor lineBottom:nil];
//        [self.pAdaptor.pSources addEntity:empty withSection:[SetEmptyListSection class]];
//        
//        SetEntity* entity3 = [SetEntity new];
//        entity3.title = @"在线咨询";
//        entity3.tag = 3;
//        entity3.selectionStyle = UITableViewCellSelectionStyleGray;
//        //    entity3.lineBottomColor = kCellLineColor;
//        entity3.selectedBgColor = QU_FLAT_COLOR_CELL_BG_SELECTED;
//        [self.pAdaptor.pSources addEntity:entity3 withSection:[SetSimpleListSection class]];
//        
//    }
//    
//    empty = [QUEntity entityWithLineTop:kCellLineColor lineBottom:nil];
//    [self.pAdaptor.pSources addEntity:empty withSection:[SetEmptyListSection class]];
//    
//    [self.pAdaptor setSectionFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 15) sectionClassName:@"AppFlatEmptySection"];
//    [self.pAdaptor notifyChanged];
//    
//}
//
//
//
//-(void)changeListState{
//    if ([UserInfoManager hasLogin]) {
//        DEFINED_WEAK_SELF
//        
//        __weak NSString* p_type = [ProductsManager shareProductsManager].selectedProduct.p_type;
//        [[UserInfoManager shareUserInfoManager] refreshLimitWithType:p_type andBlock:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
//            if([entity isKindOfClass:[QuotaGetEntity class]]){
//                [_self renderLimit:(QuotaGetEntity *)new];
//            }
//        }];
//        [[UserInfoManager shareUserInfoManager] refreshLimitWithType:@"stock_5" andBlock:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
//            if([entity isKindOfClass:[QuotaGetEntity class]]){
//                [_self renderLimit:(QuotaGetEntity *)new];
//            }
//        }];
//        
//        
//        [[UserInfoManager shareUserInfoManager] refreshCpb:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
//            CPBAmountEntity* cpbEntity = (CPBAmountEntity*)entity;
//            if (cpbEntity && [cpbEntity.result isEqualToString:@"Y"] && cpbEntity.available && [cpbEntity.available doubleValue] >= 0) {
//                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//                [formatter setPositiveFormat:@"###,##0.00;"];
//                NSString *money = @"";
//                
//                NSNumber *availableMoney = [NSNumber numberWithDouble:[cpbEntity.available doubleValue]];
//                money = [formatter stringFromNumber:availableMoney];
//                
//                
//                SetEntity* e = (SetEntity*)[_self.pAdaptor.pSources entityWithTag:5];
//                e.desc = [NSString stringWithFormat:@"¥%@",money];
//                [_self.pAdaptor notifyChanged];
//            }
//        }];
//        [[ProductsManager shareProductsManager] checkLevel:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
//            CheckLevelEntity* ent = (CheckLevelEntity*)entity;
//            if (ent) {
//                SetEntity* e = (SetEntity*)[_self.pAdaptor.pSources entityWithTag:999];
//                e.desc = ent.name;
//                [_self.pAdaptor notifyChanged];
//            }
//        }];
//        
//    }
//}
//
//-(void)renderLimit:(QuotaGetEntity*)entity{
//    if ([entity.res_data isKindOfClass:[NSDictionary class]]) {
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        [formatter setPositiveFormat:@"###,##0;"];
//        if(entity.res_data[@"stock"]){
//            NSDictionary *dict = entity.res_data[@"stock"];
//            NSNumber *limitMoney = [NSNumber numberWithDouble:[dict[@"quota"] floatValue]/10000];
//            self.limitLabel.text = [NSString stringWithFormat:@"%@万",[AppUtil moneyFloatFormat:[limitMoney floatValue]]];
//        }
//        if(entity.res_data[@"stock_5"]){
//            NSDictionary *dict = entity.res_data[@"stock_5"];
//            NSNumber *limitMoney = [NSNumber numberWithDouble:[dict[@"quota"] floatValue]/10000];
//            self.limit5Label.text = [NSString stringWithFormat:@"%@万",[AppUtil moneyFloatFormat:[limitMoney floatValue]]];
//        }
//        
//    }
//}
//
//-(void)QUAdaptor:(QUAdaptor *)adaptor forSection:(QUSection *)section forEntity:(QUEntity *)entity{
//    
//    if ([section isKindOfClass:[SetListSection class]]) {
//        SetEntity* e = (SetEntity*)entity;
//        SetListSection* s = (SetListSection*)section;
//        s.title.text = e.title;
//        s.titleImgImage.image = e.titleImg;
//        s.desc.text = e.desc;
//        if (e.showAlertImg) {
//            s.messageImage.hidden=NO;
//        }
//        
//    }
//    
//    if ([section isKindOfClass:[SetSimpleListSection class]]) {
//        SetEntity* e = (SetEntity*)entity;
//        SetSimpleListSection* s = (SetSimpleListSection*)section;
//        s.title.text = e.title;
//    }
//}
//
//-(void)QUAdaptor:(QUAdaptor *)adaptor selectedSection:(QUSection *)section entity:(QUEntity *)entity{
//    
//    
//    if(entity.tag == 5)
//    {
//        CPBAmountEntity* e = [UserInfoManager shareUserInfoManager].cpbEntity;
//        if (e) {
//            CPBAmountViewController *controller = [[CPBAmountViewController alloc]initWithNibName:@"CPBAmountViewController" bundle:nil];
//            controller.available = e.available;
//            controller.freeze = e.freeze;
//            [self.navigationController pushViewController:controller animated:YES];
//        }else{
//            DEFINED_WEAK_SELF
//            [[ViewControllerManager sharedManager] showWaitView:self.view];
//            [[UserInfoManager shareUserInfoManager] refreshCpb:^(ReturnValue *val, QUMock *mock, QUEntity *entity) {
//                [[ViewControllerManager sharedManager] hideWaitView];
//                CPBAmountEntity* ent = (CPBAmountEntity*)entity;
//                CPBAmountViewController *controller = [[CPBAmountViewController alloc]initWithNibName:@"CPBAmountViewController" bundle:nil];
//                controller.available = ent.available;
//                controller.freeze = ent.freeze;
//                [_self.navigationController pushViewController:controller animated:YES];
//            }];
//        }
//        
//        
//    }
//    
//    if (entity.tag == 6) {
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string = @"策略好了吗";
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"已复制“策略好了吗”微信公众号，请打开微信添加" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开", nil];
//        [alert show];
//    }
//    
//    if (entity.tag == 4) {
//        DissentAndCompensateViewController *controller = [[DissentAndCompensateViewController alloc]initWithNibName:@"DissentAndCompensateViewController" bundle:nil];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//    if(entity.tag == 7){
//        
//        NSString *time=[NSString stringWithFormat:@"%ld",[[ProductsManager shareProductsManager]getServerTime]];
//        NSString *key = @"msg_reset_time";
//        [[NSUserDefaults standardUserDefaults] setObject:time forKey:key];
//        
//        
//        SetListSection* s = (SetListSection*)section;
//        s.messageImage.hidden=YES;
//        MessageViewController* controller = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    }
//    
//    
//    if (entity.tag == 8) {
//        CustomServiceController *controller = [[CustomServiceController alloc]initWithNibName:@"CustomServiceController" bundle:nil];
//        
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//    
//    if (entity.tag == 10) {
//        SetViewController* controller = [[SetViewController alloc]initWithNibName:@"SetViewController" bundle:nil];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//    
//    if (entity.tag == 11) {
//        StrategyViewController *controller = [[StrategyViewController alloc]initWithNibName:@"StrategyViewController" bundle:nil];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//    if (entity.tag == 1) {
//        [self goToNoviceGuidanceWebView];
//    }
//    if (entity.tag == 2) {
//        [self goToQuestionWebView];
//    }
//    if (entity.tag == 3) {
//        [self goToMyCustomerService];
//    }
//    
//    if(entity.tag == 999){
//        [self levelClicked];
//    }
//    
//}
//
//-(void)goToMyCustomerService{
//    
//    MyWebViewController *controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url=self.url;
//    NSRange str = [controller.url rangeOfString:@"?"];
//    if (str.location!=NSIntegerMax) {
//        controller.url = [NSString stringWithFormat:@"%@&session_id=%@",controller.url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    }else{
//        controller.url = [NSString stringWithFormat:@"%@?session_id=%@",controller.url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    }
//    
//    controller.title= @"在线咨询";
//    [self.navigationController pushViewController:controller animated:YES];
//    
//}
//
////新手指导
//-(void)goToNoviceGuidanceWebView{
//    
//    
//    [MobClick beginEvent:@"novice_guide"];
//    MyWebViewController* controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url = [NSString stringWithFormat:@"%@/message/guide?&session_id=%@",[ConfigManager shareConfigManager].h5Url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    controller.title = @"新手引导";
//    [self.navigationController pushViewController:controller animated:YES];
//    [MobClick endEvent:@"novice_guide"];
//}
//
//-(void)goToQuestionWebView{
//    
//    [MobClick beginEvent:@"common_question"];
//    if (![UserInfoManager hasLogin]) {
//        [[PasswordWindow shareWindow] showWithLogin];
//        [MobClick endEvent:@"common_question"];
//        return;
//    }
//    
//    MyWebViewController* controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url = [NSString stringWithFormat:@"%@/message/commonQuestion?&session_id=%@",[ConfigManager shareConfigManager].h5Url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    controller.title = @"常见问题";
//    [self.navigationController pushViewController:controller animated:YES];
//    
//    
//}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex!= alertView.cancelButtonIndex) {
//        [MobClick beginEvent:@"open_wechat"];
//        NSString *str = @"weixin://";
//        
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
//        [MobClick endEvent:@"open_wechat"];
//    }
//}
//
//-(void)levelClicked{
//    MyWebViewController* controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url = [NSString stringWithFormat:@"%@/riskcontrol/qualification/index?session_id=%@",[ConfigManager shareConfigManager].h5Url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    controller.title = @"认证等级";
//    controller.isBack2History = NO;
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//
//- (IBAction)goBack:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (IBAction)limit0Clicked:(id)sender {
//    MyWebViewController* controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url = [NSString stringWithFormat:@"%@/riskcontrol/quota/index?type=0&session_id=%@",[ConfigManager shareConfigManager].h5Url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    controller.title = @"T+1额度";
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//- (IBAction)limit5Clicked:(id)sender {
//    MyWebViewController* controller = [[MyWebViewController alloc]initWithNibName:@"MyWebViewController" bundle:nil];
//    controller.url = [NSString stringWithFormat:@"%@/riskcontrol/quota/index?type=5&session_id=%@",[ConfigManager shareConfigManager].h5Url,[[UserInfoManager shareUserInfoManager] getSessionID]];
//    controller.title = @"T+5额度";
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//@end
