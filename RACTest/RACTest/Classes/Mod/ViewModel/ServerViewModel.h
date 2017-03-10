//
//  ServerViewModel.h
//  RACTest
//
//  Created by  rjt on 17/2/21.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewModel.h"

@interface ServerViewModel : AppViewModel
+(instancetype)sharedInstance;

-(void)updateServerTime;

@property (nonatomic,readonly) NSInteger serverTime;

@end
