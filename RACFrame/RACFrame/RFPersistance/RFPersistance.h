//
//  RFPersistance.h
//  RACFrame
//
//  Created by  rjt on 17/2/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

//AOP注册宏
#define Describe_PropertyName(...) \
dynamic __VA_ARGS__ ;\
Function_PropertyName(__VA_ARGS__)\
\

#define Function_PropertyName(...)\
-(NSArray*)getPropertyNames{\
    return [@#__VA_ARGS__ componentsSeparatedByString:@","];\
}\
\


/**
 本地持久化基类，需要持久化的类继承子类并把所有持久化属性设置为@dynamic并可使用@Describe_PropertyName宏标注所有属性名称（数据库持久化中必须使用）
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

-(void)remove;

/**
 提交当前对象的改变
 */
-(void)commit;


/**
 获取当前持久对象的所有属性名字，可以使用@Describe_PropertyName来快速完成

 @return 返回所有属性的名称
 */
-(NSArray*)getPropertyNames;

@end
