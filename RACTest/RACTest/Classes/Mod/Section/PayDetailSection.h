//
//  PayDetailSection.h
//  STO
//
//  Created by  rjt on 16/12/27.
//  Copyright © 2016年 JYZD. All rights reserved.
//

@interface PayDetailSection : UIView

@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIView *userprofitView;
@property (weak, nonatomic) IBOutlet UILabel *userprofitLabel;
@property (weak, nonatomic) IBOutlet UILabel *userprofitdescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profitwinImg;
@property (weak, nonatomic) IBOutlet UILabel *profitwinLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitloseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profitloseImg;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property (weak, nonatomic) IBOutlet UILabel *buywayLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *fundLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellfundLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *dissentBtn;
@property (weak, nonatomic) IBOutlet UILabel *dissentLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@end
