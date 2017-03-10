//
//  PaySection.h
//  STO
//
//  Created by  rjt on 16/12/27.
//  Copyright © 2016年 JYZD. All rights reserved.
//

@interface PaySection : UIView<IRFSection>
@property (weak, nonatomic) IBOutlet UILabel *createtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *stoceknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *limitImg;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultdescLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *doBtn;

@end
