//
//  HomeSection.m
//  A50
//
//  Created by  rjt on 15/10/11.
//  Copyright © 2015年 JYZD. All rights reserved.
//

#import "HomeSection.h"
#import "UIImageView+WebCache.h"
#import "AdEntity.h"

@implementation HomeSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end

@implementation AdvSection
-(void)awakeFromNib{
    [super awakeFromNib];
    placeHolderImg = [UIImage imageNamed:@"banner_loading"];
    self.scrollView.showsHorizontalScrollIndicator = NO; //不显示水平滑动线
    self.scrollView.showsVerticalScrollIndicator = NO;//不显示垂直滑动线
    self.scrollView.pagingEnabled=YES;//scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
    self.scrollView.delegate = self;
    
    self.page.userInteractionEnabled=NO; //pagecontroller不响应点击操作
    
    gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdv:)];
    [self addGestureRecognizer:gesture];
    
    //自动调整高度
    CGRect r = self.frame;
    r.size.height = kCurrentDeviceWidth/r.size.width * r.size.height;
    self.frame = r;
    
    
}

-(void)sectionWillDidLoad{
    [self loadAdvs:nil];
    _endSignal = [self rac_signalForSelector:@selector(scrollViewWillBeginDecelerating:) fromProtocol:@protocol(UIScrollViewDelegate)];
    @weakify(self)
    [_endSignal subscribeNext:^(id x) {
        @strongify(self);
        [self resetTime];
    }];
    [self resetTime];
    _tapSignal = [RACSubject subject];
}

-(void)resetTime{
    @weakify(self)
    _timeSignal = [[RACSignal interval:6 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:_endSignal];
    [_timeSignal subscribeNext:^(id x) {
        @strongify(self)
        [self scroll2Next];
    }];
}

- (void)tapAdv:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIImageView *selectedImage = (UIImageView *)tap.view;
    AdRecordsEntity *entity = advs[selectedImage.tag - 1000];
    [_tapSignal sendNext:entity];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    NSInteger page = offset.x / (self.bounds.size.width);
    [self scroll2Page:page-1 needDelay:NO];
}

-(void)scroll2Page:(NSInteger)page needDelay:(BOOL)delay{
    if (self.page.numberOfPages>1) {
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * (page+1),self.scrollView.contentOffset.y) animated:YES];
        if (page>=self.page.numberOfPages) {
            self.page.currentPage = 0; //计算当前的页码
            if (delay) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * (self.page.currentPage+1),self.scrollView.contentOffset.y) animated:NO]; //返回首页
                });
            }else{
                [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * (self.page.currentPage+1),self.scrollView.contentOffset.y) animated:NO]; //返回首页
            }
            
            
        }else if(page<0){
            self.page.currentPage = self.page.numberOfPages - 1; //计算当前的页码
            if (delay) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * (self.page.currentPage+1),self.scrollView.contentOffset.y) animated:NO]; //返回首页
                });
            }else{
                [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * (self.page.currentPage+1),self.scrollView.contentOffset.y) animated:NO]; //返回首页
            }
            
        }
        else{
            self.page.currentPage = page; //计算当前的页码
        }
    }

}

-(void)scroll2Next{
//    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * (self.page.currentPage+1),self.scrollView.contentOffset.y) animated:YES]; //设置scrollview的显示为当前滑动到的页面
    [self scroll2Page:self.page.currentPage+1 needDelay:YES];
}

-(void)loadAdvs:(NSArray *)ads{
    if (ads) {
        if (ads!=advs) {
            advs = ads;
            self.page.numberOfPages = [advs count];
            self.page.currentPage = 0;
            for (UIView *aView in self.scrollView.subviews) {
                [aView removeFromSuperview];
            }
            self.scrollView.contentSize=CGSizeMake(self.bounds.size.width*(advs.count+2), self.bounds.size.height);
            
            UIImageView *firstImg = [[UIImageView alloc] init];
            UIImageView *lastImg = [[UIImageView alloc] init];
            lastImg.tag = 1000 + advs.count - 1;
            firstImg.tag = 1000 + 0;
            AdRecordsEntity *ent = advs[[advs count]-1];
            [lastImg sd_setImageWithURL:[NSURL URLWithString:ent.pic] placeholderImage:placeHolderImg];
            CGRect rect = self.frame;
            rect.origin.x = 0;
            lastImg.frame = rect;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdvsender:)];
            [lastImg addGestureRecognizer:tap];
            lastImg.userInteractionEnabled = YES;
            
            [self.scrollView addSubview:lastImg];
            for (int i=0; i<[advs count]; ++i) {
                AdRecordsEntity *e = advs[i];
                UIImageView *image = [[UIImageView alloc] init];
                image.tag = 1000 + i;
                [image sd_setImageWithURL:[NSURL URLWithString:e.pic] placeholderImage:placeHolderImg];
                CGRect rect = self.frame;
                rect.origin.x = (i+1)*rect.size.width;
                image.frame = rect;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdvsender:)];
                [image addGestureRecognizer:tap];
                image.userInteractionEnabled = YES;
                if (i==0) {
                    [firstImg sd_setImageWithURL:[NSURL URLWithString:e.pic] placeholderImage:placeHolderImg];
                    CGRect rect = self.frame;
                    rect.origin.x = ([advs count]+1)*rect.size.width;
                    firstImg.frame = rect;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdvsender:)];
                    [firstImg addGestureRecognizer:tap];
                    firstImg.userInteractionEnabled = YES;
                }
                [self.scrollView addSubview:image];
            }
            [self.scrollView addSubview:firstImg];
            [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width ,self.scrollView.contentOffset.y) animated:NO];
        }
    }else{
        //放置默认图片
        self.page.numberOfPages = 1;
        self.page.currentPage = 0;
        UIImageView *image = [[UIImageView alloc] initWithImage:placeHolderImg];
        image.frame = self.bounds;
        [self.scrollView addSubview:image];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@implementation IndexSection

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(void)sectionWillLoad{

}
@end



@implementation CalendarSection

-(void)awakeFromNib{

    self.lineView = [[UIView alloc] init];
//    self.lineView.backgroundColor = Color_Bg_Text_Chosed_Orange;
    self.lineView.frame = CGRectMake(self.strategyButton.frame.origin.x, self.strategyButton.frame.size.height, self.strategyButton.frame.size.width, 1.5);
    [self addSubview:self.lineView];

    self.graphies = [[NSMutableArray alloc] init];
    self.btns = [[NSMutableArray alloc] init];

    
//    [self.graphies addObject:self.strategyTable];
//    [self.btns addObject:self.strategyBtn];
//    
//    [self.graphies addObject:self.winTable];
//    [self.btns addObject:self.winBtn];
    self.strategyButton.tag = 1;
    [self.graphies addObject:self.strategyTable];
    [self.btns addObject:self.strategyButton];
    
    self.winButton.tag = 2;
    [self.graphies addObject:self.winTable];
    [self.btns addObject:self.winButton];

    
//    self.btnView.hidden = YES;//暂时隐去
    
    [self clickBtnDisplayGraph:self.strategyButton];

}

-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    self.lineView.frame = CGRectMake(selectBtn.frame.origin.x, selectBtn.frame.size.height, selectBtn.frame.size.width, 1.5);
}

#pragma mark - 按钮点击事件
- (IBAction)clickBtnDisplayGraph:(UIButton *)btn {

//    NSInteger flag = btn.tag;
//    
//    selectBtn.selected = NO;
//    btn.selected = YES;
//    for (int i=0; i<self.btns.count; ++i) {
//        UIButton* b = (UIButton*)self.btns[i];
//        UITableView* t = (UITableView*)self.graphies[i];
//        if (b == btn) {
//            if(flag == 1){
//            
//                self.cooperateCostLabel.textColor = Color_Bg_Text_Chosed_Orange;
//                [self.strategyBtn setTitleColor:Color_Bg_Text_Chosed_Orange forState:UIControlStateNormal];
//                [self.winBtn setTitleColor:Color_Bg_222222 forState:UIControlStateNormal];
//                self.earnCostLabel.textColor = Color_Bg_222222;
//                self.cooperateCostView.backgroundColor = Color_Bg_RGB(255, 255, 255);
//                self.earnCostView.backgroundColor = Color_Bg_RGB(250, 250, 250);
//            }else{
//            
//                self.cooperateCostLabel.textColor = Color_Bg_222222;
//                [self.strategyBtn setTitleColor:Color_Bg_222222 forState:UIControlStateNormal];
//                [self.winBtn setTitleColor:Color_Bg_Text_Chosed_Orange forState:UIControlStateNormal];
//                self.earnCostLabel.textColor = Color_Bg_Text_Chosed_Orange;
//                self.earnCostView.backgroundColor = Color_Bg_RGB(255, 255, 255);
//                self.cooperateCostView.backgroundColor = Color_Bg_RGB(250, 250, 250);
//            }
//            t.hidden = NO;
////            [b setTitleColor:Color_Bg_Text_Chosed_Orange forState:UIControlStateSelected];
//            //首尾式动画
//            [UIView beginAnimations:nil context:nil];
//            //执行动画
//            //设置动画执行时间
//            [UIView setAnimationDuration:0.3f];
//            self.lineView.frame = CGRectMake(btn.frame.origin.x, btn.frame.size.height, btn.frame.size.width, 1.5);
//            [UIView commitAnimations];
//            
//            
//        }else{
//            t.hidden = YES;
////            [btn setTitleColor:Color_Bg_222222 forState:UIControlStateNormal];
//        }
//    }
//    selectBtn = btn;
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end


@implementation WinSection
-(void)awakeFromNib{
//    [self fixLabelWithSmallScreen];
//    self.publishBtn.layer.cornerRadius = 2;
//    self.publishBtn.layer.borderColor = kBtnColor.CGColor;
//    self.publishBtn.layer.borderWidth = .5f;
}

@end


@implementation TotalSection



@end


@implementation ListSection



@end

@implementation ListViewSection



@end


@implementation TargetExcuteSection



@end

@implementation TargetInfoSection



@end


