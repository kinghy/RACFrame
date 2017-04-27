//
//  RFDBPersistManager.h
//  RACFrame
//
//  Created by  rjt on 17/4/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 SQLite持久化管理类
 */

@class FMDatabase,FMDatabaseQueue;

@interface RFDBPersistManager : NSObject<IRFPersistManager>{
    FMDatabase *_fmdb;
    FMDatabaseQueue *_dbQueue;
    NSString *_documents;
    NSMutableDictionary<NSString*,NSNumber*>* _tableDict;
}
/**
 构造方法，单例
 
 @return 单例
 */
+(instancetype)sharedInstace;

/**
 根据类名、tag从DB中获取RFPersistance实例,如果没有在DB中找到相应的持久化对象则返回一个新建的RFPersistance实例。
 
 @param clss 类名，必须是RFPersistance子类
 @param tag tag
 @return 返回clss的实例，如果clss不晒RFPersistance子类则返回nil
 */
-(RFPersistance *)persistanceByClass:(Class)clss andTag:(NSString *)tag;

-(NSArray<RFPersistance*>*)persistancesByClass:(Class)clss andQuery:(NSString*)query;


/**
 UserDefaults不提供条件检索
 
 */
-(NSArray<RFPersistance *> *)loadPersistancesByClass:(Class)clss andFilte:(NSDictionary *)filtes NS_UNAVAILABLE;

/**
 根据类名、tag从DB中获取NSMutableDictionary实例,如果没有在UserDefaults中找到相应的存储对象则返回一个新建的NSMutableDictionary实例。
 
 @param clss 类名，必须是RFPersistance子类
 @param tag tag
 @return 返回NSMutableDictionary的实例
 */
-(NSMutableDictionary *)dictByClass:(Class)clss andTag:(NSString *)tag;

/**
 将给定persistance保存到DB
 
 @param persistance 需要保存的persistance
 @return 返回是否保存成功
 */
-(BOOL)saveByPersistance:(RFPersistance *)persistance;

/**
 将给定persistance数组保存到DB
 
 @param persistances 需要保存的persistance数组
 @return 返回是否保存成功
 */
-(BOOL)saveByPersistanceArray:(NSArray<RFPersistance*> *)persistances;


/**
 从DB中移除persistance，方法不会改变传入的persistance
 
 @param persistance 需要移除的persistance
 @return 返回移除结果
 */
-(BOOL)removeByPersistance:(RFPersistance *)persistance;
@end
