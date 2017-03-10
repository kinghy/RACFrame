//
//  IRFPersistManager.h
//  RACFrame
//
//  Created by  rjt on 17/2/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#ifndef IRFPersistManager_h
#define IRFPersistManager_h
@class RFPersistance;
@protocol IRFPersistManager <NSObject>
@required
/**
 根据类名、tag从本地持久化中获取RFPersistance实例,如果没有在本地持久化中找到相应的存储对象则返回一个新建的RFPersistance实例。
 
 @param clss 类名，必须是RFPersistance子类
 @param tag tag
 @return 返回clss的实例，如果clss不是RFPersistance子类则返回nil
 */
-(RFPersistance*)persistanceByClass:(Class)clss andTag:(NSString *)tag;

-(NSArray<RFPersistance*>*)persistancesByClass:(Class)clss andFilte:(NSDictionary *)filtes;

/**
 根据类名、tag从本地持久化中获取NSMutableDictionary实例,如果没有在本地持久化中找到相应的存储对象则返回一个新建的NSMutableDictionary实例。

 @param clss 类名，必须是RFPersistance子类
 @param tag tag
 @return 返回NSMutableDictionary的实例
 */
-(NSMutableDictionary*)dictByClass:(Class)clss andTag:(NSString *)tag;

/**
 将给定persistance进行持久化

 @param persistance 需要保存的persistance
 @return 返回是否保存成功
 */
-(BOOL)saveByPersistance:(RFPersistance*)persistance;

/**
 从UserDefaults中移除persistance，方法不会改变传入的persistance
 
 @param persistance 需要移除的persistance
 @return 返回移除结果
 */
-(BOOL)removeByPersistance:(RFPersistance *)persistance;

@end
#endif /* IRFPersistManager_h */
