//
//  PayDetailViewModel.m
//  STO
//
//  Created by  rjt on 16/12/29.
//  Copyright © 2016年 JYZD. All rights reserved.
//

#import "PayDetailViewModel.h"
#import "OrderDetailsEntity.h"
#import "DoSettleEntity.h"
#import "OrderDetailsParam.h"
#import "DoSettleParam.h"
#import "DissentOrderParam.h"

//#import "STODBManager.h"

@implementation PayDetailViewModel


#pragma mark - init methods
+(instancetype)viewModelWithPid:(NSString *)pid andPType:(NSString*)ptype{
    PayDetailViewModel* model = [[PayDetailViewModel alloc] initWithPid:pid andPType:ptype];
    
    return model;
}

-(instancetype)initWithPid:(NSString *)pid andPType:(NSString*)ptype{
    if(self = [super initWithoutDidLoad]){
        
        _pID = pid;
        _pType = ptype;
        [self viewModelDidLoad];
    }
    return self;
}
#pragma mark - extends methods
-(void)viewModelDidLoad{
    [super viewModelDidLoad];
    [self loadViewModel];
    @weakify(self)
    self.doCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self doSettle];
    }];
    
    self.dissentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            if([self.dissentFlg isEqualToString:@"1"]){
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            }else if([self.dissentFlg isEqualToString:@"2"]){
                [subscriber sendError:[NSError errorWithDomain:@"dissentCommand" code:1000 userInfo:@{@"msg":@"预计两个工作日内处理完成"}]];
            }
            return nil;
        }];
    }];
    
    self.doDissentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self doDissent:subscriber];
            return nil;
        }];
    }];
    _dissentPointDict = @{kDissentPointInfoStr:kDissentPointInfoKey,kDissentPointBuyStr:kDissentPointBuyKey,kDissentPointSellStr:kDissentPointSellKey,kDissentPointProfitStr:kDissentPointProfitKey,kDissentPointCheckStr:kDissentPointCheckKey,kDissentPointOtherStr:kDissentPointOtherKey};
    RAC(self, dissentPoint) = [RACObserve(self, dissentPointStr) map:^id(id value) {
        @strongify(self);
        NSString *key;
        if([value isEqualToString:kDissentPointProfitStr]){
            key = [self.profit floatValue]>=0?kDissentPointWinKey:kDissentPointLossKey;
        }else{
            key = [self.dissentPointDict objectForKey:value];
        }
        return key;
    }];

    RAC(self, dissentCurrentValue) = [RACObserve(self, dissentPoint) map:^id(NSString* str) {
        @strongify(self);
        NSString *tmp;
        if([str isEqualToString:kDissentPointInfoKey]){
            tmp =[NSString stringWithFormat:@"%.2f",[self.infoFee floatValue]];
        }else if([str isEqualToString:kDissentPointBuyKey]){
            tmp =[NSString stringWithFormat:@"%.2f",[self.startPrice floatValue]];
        }else if([str isEqualToString:kDissentPointSellKey]){
            tmp =[NSString stringWithFormat:@"%.2f",[self.sellStartPrice floatValue]];
        }else if([str isEqualToString:kDissentPointWinKey] || [str isEqualToString:kDissentPointLossKey]){
            tmp = [NSString stringWithFormat:@"%.2f",[self.userProfit floatValue]];
        }else if([str isEqualToString:kDissentPointCheckKey]){
            tmp = [self.settlemntFlag isEqualToString:@"1"]?@"已结算":@"未结算";
        }else{
            tmp = @"无";
        }
        return tmp;
    }];
}

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods

-(void)refresh{
    [self loadViewModel];
}

-(void)loadViewModel{
    @weakify(self)
    OrderDetailsParam *param = [OrderDetailsParam new];
    param.p_type = self.pType;
    param.p_id = self.pID;
    [[RFNetAdapter netAdapterWithParam:param].signal subscribeNext:^(id x) {
        @strongify(self)
        if ([x isKindOfClass:[OrderDetailsEntity class]]) {
            OrderDetailsEntity* e = (OrderDetailsEntity*)x;
            self.stockName = e.stock_name;
//            self.stockCode =[[STODBManager shareSTODBManager]getStockCode:e.code];
            self.stockCode = e.code;
            self.userProfit = e.user_profit;
            self.limit = e.sub_type?[NSString stringWithFormat:@"T+%@",[e.sub_type isEqualToString:@"0"]?@"1":e.sub_type]:nil;
            self.buyWay = e.buy_type;
            self.amount = e.sell_amount_float;
            self.fund = [NSString stringWithFormat:@"%.2f",[e.buy_fund floatValue]];
            self.sellFund = [e.state isEqualToString:kSettleCreateCheck]?nil:[NSString stringWithFormat:@"%.2f",[e.sell_fund floatValue]];

            self.state = e.state;
            self.stateName = e.state_name;
            [self changeDissentFlg:e.dissent_flag];
            self.pno = e.pno;
            self.startPrice = e.start_price;
            self.sellStartPrice = e.sell_start_price;
            self.profit = [e.state isEqualToString:kSettleCreateCheck]?nil:e.profit;

            self.stopLossPoint = e.stop_loss_point;
            self.settlemntFlag = e.settlemnt_flag;
            self.infoFee = e.info_fee;
            self.winProfitRate = [e.distribution objectForKey:@"user_profit"];
        }
    }];
}

-(void)changeDissentFlg:(NSString*)flg{
    self.dissentFlg = flg;
    if([flg isEqualToString:@"1"]){
        [self startDissentTimer];
    }else if([flg isEqualToString:@"2"]){
        self.dissentTime = @"异议申请中";
    }else{
        self.dissentTime = @"";
    }
}

-(void)startDissentTimer{
    NSInteger time = [ServerViewModel sharedInstance].serverTime;
    self.dissentTime = [self runDissentTimer:time];
    RACSignal *stopSignal = [RACObserve(self, dissentFlg) filter:^BOOL(id value) {
        if([value isEqualToString:@"1"]){
            return NO;
        }else{
            return YES;
        }
    }];
    RACSignal *timeSignal = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:stopSignal];
    @weakify(self)
    RAC(self,dissentTime) = [timeSignal scanWithStart:self.dissentTime reduceWithIndex:^id(id running, id next, NSUInteger index) {
        @strongify(self)
        return [self runDissentTimer:time+index];
    }];
}

-(NSString*)runDissentTimer:(NSInteger)time{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // 获得一个时间元素
    NSCalendarUnit  unit =NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *components = [gregorian components:unit fromDate:date];
    [components setDay:([components day]+1)];//明天
    [components setMinute:0];
    [components setHour:0];
    [components setSecond:0];
    
    NSDate *deadDate = [gregorian dateFromComponents:components];
    if(deadDate.timeIntervalSince1970>=date.timeIntervalSince1970){
        NSDateComponents *c = [gregorian components:unit fromDate:date toDate:deadDate options:kNilOptions];
        return [NSString stringWithFormat:@"异议申请 %02zd:%02zd:%02zd",c.hour,c.minute,c.second];
    }else{
        [self changeDissentFlg:@"0"];
        return @"";
    }
}

-(RACSignal *)doSettle{
    DoSettleParam *param = [DoSettleParam new];
    param.p_id = self.pID;
    param.p_type = self.pType;
    RACSignal* signal = [RFNetAdapter netAdapterWithParam:param].signal;
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        [signal subscribeNext:^(id x) {
            @strongify(self)
            if([self.state isEqualToString:kSettleDoPay]){
                self.state = kSettleDoSettling;
                self.stateName = kSettleDoSettlingStr;
            }
            [subscriber sendNext:self.state];
            [subscriber sendCompleted];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

-(void)doDissent:(id<RACSubscriber>)subscriber{
    NSString *errorMsg = nil;
    
    if (!self.dissentPoint) {
        errorMsg = @"请选择异议点";
    }else if (self.dissentReasonText.length==0) {
        errorMsg = @"请输入您的理由";
    }else if(self.dissentReasonText.length>150){
        errorMsg = @"您的理由不能超过150字";
    }else if(self.dissentReasonText.length<5){
        errorMsg = @"您的理由不足5个字";
    }else if(([_dissentPoint isEqualToString:kDissentPointInfoKey] || [_dissentPoint isEqualToString:kDissentPointBuyKey]
             || [_dissentPoint isEqualToString:kDissentPointSellKey]|| [_dissentPoint isEqualToString:kDissentPointWinKey]|| [_dissentPoint isEqualToString:kDissentPointLossKey] ) && _dissentValue.length == 0){
        errorMsg = @"请填写您认为的值";
    }
    
    if(errorMsg){
        NSError *error = [NSError errorWithDomain:[[self class] description] code:1000 userInfo:@{kErrorMsg:errorMsg}];
        [subscriber sendError:error];
    }else{
        DissentOrderParam *param = [DissentOrderParam new];
        param.reason = _dissentReasonText;
        
        param.p_id = _pID;
        param.p_type = _pType;
        param.point = _dissentPoint;
        param.price = _dissentValue.length>0?_dissentValue:@"0";
    
        
        [[RFNetAdapter netAdapterWithParam:param].signal subscribeNext:^(id x) {
            [subscriber sendNext:x];
        }error:^(NSError *error) {
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];
        
    }
}

@end

