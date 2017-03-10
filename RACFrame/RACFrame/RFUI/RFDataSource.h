//
//  RFDataSource.h
//  RACFrame
//
//  Created by  rjt on 17/3/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

@interface RFDataSource : NSObject
@property (nonatomic,strong,readonly)NSMutableArray *records;
@property (nonatomic,strong,readonly)RACSubject *recordsSignal;
@property (nonatomic,strong,readonly)RACSubject *errorsSignal;

/**
 接受网络信号，信号sendNext值需要一个NSArray对象，完成处理后recordsSignal

 @param netSignal 网络信号需要sendNext值需要一个NSArray对象
 @param clear 是否需要清空记录
 */
-(void)refresh:(RACSignal *)netSignal andClear:(BOOL)clear;
@end
