//
//  HomeViewController.m
//  RACTest
//
//  Created by  rjt on 17/2/15.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeSection.h"


@interface HomeViewController ()<RFTableDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - init methods

#pragma mark - extends methods

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationBarHidden:NO statusBarStyle:UIStatusBarStyleDefault title:@"策略好了吗"];
}

-(void)bindViewModel{
    [self.pTable rftableWithController:self andNibArray:@[@"HomeSection"]];
    [self.pTable addEntity:[NSObject new] withSection:[AdvSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[IndexSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[TargetInfoSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    [self.pTable addEntity:[NSObject new] withSection:[ListSection class]];
    
    

}
#pragma mark - public methods

#pragma mark - private methods

#pragma mark - delegate methods
#pragma mark - Action methods

@end
