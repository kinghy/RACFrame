//
//  StockPackageAspect.m
//  RACTest
//
//  Created by  rjt on 17/4/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "StockPackageAspect.h"
#import "PatchGetParam.h"
#import "PatchGetEntity.h"
#import "PatchgetPersistance.h"
#import "StockPersistance.h"
#import "RFDBPersistManager.h"

@implementation StockPackageAspect
//注册
@REGISTER_AS_ASPECTS
//实现切片
-(void)before_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions andInstance:(id)instance{
    PatchGetParam *param = [PatchGetParam new];
    param.name=@"stock_list";
    @weakify(self)
    [[RFNetAdapter netAdapterWithParam:param].signal subscribeNext:^(id x) {
        @strongify(self)
        if([x isKindOfClass:[PatchGetEntity class]]){
            PatchGetEntity *e = (PatchGetEntity*)x;
            PatchgetPersistance *p = (PatchgetPersistance*)[[RFDefaultsPersistManager sharedInstace] persistanceByClass:[PatchgetPersistance class] andTag:kStockPathgetPersistanceKey];
            
            NSString *version = [NSString stringWithFormat:@"%@",[e.res_data objectForKey:@"version"]];
            if(![version isEqualToString:p.version]){
                p.name=[NSString stringWithFormat:@"%@",[e.res_data objectForKey:@"name"]];
                p.version=[NSString stringWithFormat:@"%@",[e.res_data objectForKey:@"version"]];
                p.create_time=[NSString stringWithFormat:@"%@",[e.res_data objectForKey:@"create_time"]];
                p.flag=[NSString stringWithFormat:@"%@",[e.res_data objectForKey:@"flag"]];
                p.url=[NSString stringWithFormat:@"%@",[e.res_data objectForKey:@"url"]];
                [p commit];
                [self getStockPackage:p.url];
            }
        }
    }];
}
-(void)getStockPackage:(NSString*)url{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (data) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if ([jsonData isKindOfClass:[NSArray class]]) {
            
            NSArray *dataArray = (NSArray *)jsonData;
            NSMutableArray *pArray = [NSMutableArray array];
            for(NSDictionary *dict in dataArray){
                StockPersistance *stock = (StockPersistance*)[[RFDBPersistManager sharedInstace] persistanceByClass:[StockPersistance class] andTag:nil];
                stock.ID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
                stock.code = [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]];//String	600129
                stock.name = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];//String	太极集团
                stock.abbr = [NSString stringWithFormat:@"%@",[dict objectForKey:@"abbr"]];//String	TJJT
                stock.create_time = [NSString stringWithFormat:@"%@",[dict objectForKey:@"create_time"]];//String	1432175264
                stock.update_time = [NSString stringWithFormat:@"%@",[dict objectForKey:@"update_time"]];//String	2016-04-16 11:30:03
                stock.platetype = [NSString stringWithFormat:@"%@",[dict objectForKey:@"platetype"]];//String	沪A
                stock.code_shsz = [NSString stringWithFormat:@"%@",[dict objectForKey:@"code_shsz"]];//String	600129.SH
                stock.shsz = [NSString stringWithFormat:@"%@",[dict objectForKey:@"shsz"]];//String	SH
                [pArray addObject:stock];
            }
            
            [[RFDBPersistManager sharedInstace] saveByPersistanceArray:pArray];
        }
        
    }

}

@end
