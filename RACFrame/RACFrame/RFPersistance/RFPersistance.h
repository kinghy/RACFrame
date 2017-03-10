//
//  RFPersistance.h
//  RACFrame
//
//  Created by  rjt on 17/2/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 本地持久化基类，需要持久化的类继承子类并把所有持久化属性设置为@dynamic
 所有子类都应该调用initFromLocalWithTag:或者initWithTag:andDeadLine:进行初始化
 */
@interface RFPersistance : NSObject
@property (strong,nonatomic,readonly)NSString* persistanceTag;
@property (strong,nonatomic,readonly)NSMutableDictionary* persistanceDict;
@property (weak,nonatomic,readonly) id<IRFPersistManager> manager;

@property (strong,nonatomic) NSString* persistanceDeadLine;

-(instancetype)initWithDict:(NSMutableDictionary*)dict andTag:(NSString*)tag andManager:(id<IRFPersistManager>)manager;



///**
// 为当前对象加锁，此方法保证了接下来操作的原子性，理论上所有对持久对象的写操作都应该先调用此方法，以下所有操作都是线程安全的，请在使用完成后调用uolockWithCommit:关闭锁
//
// @param isRefresh 是否需要在加锁的同时自动更新当前对象的数据
// */
//-(void)lockWithRefresh:(BOOL)isRefresh;
//
///**
// 解锁，对应与lockWithRefresh:操作
//
// @param isCommit 是否需要在解锁值钱
// */
//-(void)unlockWithCommit:(BOOL)isCommit;

/**
 更新当前对象,更新操作会导致所有未commit的写入操作被回滚
 */
-(void)refresh;

/**
 提交当前对象的改变
 */
-(void)commit;

@end
