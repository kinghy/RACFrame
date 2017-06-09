//
//  HomeSection.h
//  A50
//
//  Created by  rjt on 15/10/11.
//  Copyright © 2015年 JYZD. All rights reserved.
//


@interface HomeSection : UIView

@end



@interface AdvSection : UIView<UIScrollViewDelegate,IRFSection>{
    NSArray* advs;
    UIImage *placeHolderImg;
    UITapGestureRecognizer *gesture;
}
@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) RACSignal *endSignal;
@property (strong, nonatomic) RACSignal *timeSignal;

@property (strong, nonatomic) RACSubject *tapSignal;

-(void)loadAdvs:(NSArray*)ads;
-(void)scroll2Next;
@end

@interface IndexSection : UIView
@property (weak, nonatomic) IBOutlet UILabel *price300Label;
@property (weak, nonatomic) IBOutlet UILabel *rate300Label;
@property (weak, nonatomic) IBOutlet UILabel *priceCreateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateCreateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceMiddleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateMiddleLabel;

@property (weak, nonatomic) IBOutlet UIButton *indexBtn;


@end



@interface CalendarSection : UIView{
    UIButton *selectBtn;
}

@property (weak, nonatomic) IBOutlet UILabel *earnCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *cooperateCostLabel;
@property (strong,nonatomic) UIView * lineView;
@property (strong,nonatomic) NSMutableArray * graphies;
@property (strong,nonatomic) NSMutableArray * btns;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIButton *strategyBtn;
@property (weak, nonatomic) IBOutlet UIButton *winBtn;
@property (weak, nonatomic) IBOutlet UITableView *strategyTable;
@property (weak, nonatomic) IBOutlet UITableView *winTable;

@property (weak, nonatomic) IBOutlet UIView *cooperateCostView;
@property (weak, nonatomic) IBOutlet UIButton *strategyButton;

@property (weak, nonatomic) IBOutlet UIButton *winButton;
@property (weak, nonatomic) IBOutlet UIView *earnCostView;



- (IBAction)clickBtnDisplayGraph:(UIButton *)btn;
@end


@interface WinSection : UIView

@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *profit;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *publishBtn;
@property (weak, nonatomic) IBOutlet UIImageView *splitLine;

@property (strong, nonatomic) NSString *stockCode;

@end


@interface TotalSection : UIView
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@interface ListSection : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *informationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *investorInformationLabel;


@property (weak, nonatomic) IBOutlet UIButton *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *excuteNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *excuteTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *excuteInformationLabel;
@property (weak, nonatomic) IBOutlet UILabel *excuteTitleLabel;



@end


@interface ListViewSection : UIView

@property (weak, nonatomic) IBOutlet UITableView *listTableView;


@end


@interface TargetExcuteSection : UIView

@property (weak, nonatomic) IBOutlet UILabel *totalDealAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalEarningLabel;



@end


@interface TargetInfoSection : UIView

@property (weak, nonatomic) IBOutlet UILabel *totalDealAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalEarningLabel;


@end



