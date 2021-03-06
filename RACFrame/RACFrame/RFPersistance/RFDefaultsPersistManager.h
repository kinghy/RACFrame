//
//  RFDefaultsPersistManager.h
//  RACFrame
//
//  Created by  rjt on 17/2/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 UserDefaults持久化管理类，由于一次读取至内存操作所以只适合与简单对象的存取
 */
@interface RFDefaultsPersistManager : NSObject<IRFPersistManager>{
    NSUserDefaults *_userDefaults;
}

/**
 构造方法，单例

 @return 单例
 */
+(instancetype)sharedInstace;

/**
 根据类名、tag从UserDefaults中获取RFPersistance实例,如果没有在UserDefaults中找到相应的持久化对象则返回一个新建的RFPersistance实例。

 @param clss 类名，必须是RFPersistance子类
 @param tag tag
 @return 返回clss的实例，如果clss不晒RFPersistance子类则返回nil
 */
-(RFPersistance *)persistanceByClass:(Class)clss andTag:(NSString *)tag;

/**
 UserDefaults不提供条件检索

 */
-(NSArray<RFPersistance *> *)loadPersistancesByClass:(Class)clss andFilte:(NSDictionary *)filtes NS_UNAVAILABLE;

/**
 根据类名、tag从UserDefaults中获取NSMutableDictionary实例,如果没有在UserDefaults中找到相应的存储对象则返回一个新建的NSMutableDictionary实例。
 
 @param clss 类名，必须是RFPersistance子类
 @param tag tag
 @return 返回NSMutableDictionary的实例
 */
-(NSMutableDictionary *)dictByClass:(Class)clss andTag:(NSString *)tag;

/**
 将给定persistance保存到UserDefaults
 
 @param persistance 需要保存的persistance
 @return 返回是否保存成功
 */
-(BOOL)saveByPersistance:(RFPersistance *)persistance;


/**
 从UserDefaults中移除persistance，方法不会改变传入的persistance

 @param persistance 需要移除的persistance
 @return 返回移除结果
 */
-(BOOL)removeByPersistance:(RFPersistance *)persistance;

@end
