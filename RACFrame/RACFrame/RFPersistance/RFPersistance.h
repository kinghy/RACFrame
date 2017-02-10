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

@property (strong,nonatomic) NSString* persistanceTag;
@property (strong,nonatomic) NSString* persistanceDeadLine;

@property (strong,nonatomic,readonly) NSMutableDictionary* persistanceDict;
@property (strong,nonatomic,readonly) NSString* className;


///**
// 新建持久层一个实例对象
// @param tag 持久层标识
// @return 新的对象
// */
//-(instancetype)initWithTag:(NSString*)tag andDeadLine:(NSInteger)deadLine;
//
//
//-(void)removeFromLocal;

@end
