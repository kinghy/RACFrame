//
//  AppViewModel.m
//  RACTest
//
//  Created by  rjt on 17/2/8.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AppViewModel.h"

@implementation AppViewModel
#pragma mark - init methods
-(instancetype)init{
    if(self = [super init]){
        [self viewModelDidLoad];
    }
    return self;
}
#pragma mark - extends methods

#pragma mark - public methods
-(void)viewModelDidLoad{

}
#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods

-(void)dealloc{
    DDLogInfo(@"%@ has dealloced",[self class]);
}
@end
