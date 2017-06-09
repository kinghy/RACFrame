//
//  AdvViewModel.m
//  RACTest
//
//  Created by  rjt on 17/5/24.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "AdvViewModel.h"
#import "AdEntity.h"
#import "AdParam.h"
#import "UserViewModel.h"
#import "MyWebViewController.h"

@implementation AdvViewModel

-(void)renew{
    [self refresh];
}

-(void)refresh{
    AdParam *p = [AdParam new];
    RACSignal* signal = [[RFNetAdapter netAdapterWithParam:p].signal map:^id(id value) {
        NSMutableArray * arr = [NSMutableArray array];
        if([value isKindOfClass:[AdEntity class]]) {
            [arr addObjectsFromArray:[(AdEntity*)value records]];
        }
        return arr;
    }];
    [self.dataSource refresh:signal andClear:YES];
}

-(void)showAdv:(AdRecordsEntity *)entity withNav:(UINavigationController *)nav{
    if ([entity.iscert isEqualToString:@"1"]) {//需要登录才能跳转
        
        
        if([[UserViewModel sharedInstance] hasLogin]) {
            [self tapAdv:entity withNav:nav];
        }else{
//            [WpCommonFunction showNotifyHUDAtViewBottom:windowsArr.lastObject withErrorMessage:@"请先登录"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGlobalLogin object:nil];

        }
    }
    else{//不必登录
        [self tapAdv:entity withNav:nav];
    }
}

-(void)tapAdv:(AdRecordsEntity *)entity withNav:(UINavigationController *)nav{
    
    MyWebViewController *web = [[MyWebViewController alloc] initWithNibName:@"MyWebViewController" bundle:nil];

    if(entity.title){
        web.title = entity.title;
    }else{
        web.title = kAppName;
    }
    
    web.url = entity.link;
    [nav pushViewController:web animated:YES];
    
}
@end
