//
//  RFPersistance.m
//  RACFrame
//
//  Created by  rjt on 17/2/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFPersistance.h"
#import <objc/runtime.h>

static NSRecursiveLock *persistancLock;//递归锁

@implementation RFPersistance

@dynamic persistanceDeadLine;

#pragma mark - init methods

-(instancetype)initWithDict:(NSMutableDictionary *)dict andTag:(NSString *)tag andManager:(id<IRFPersistManager>)manager{
    if(self = [self init]){
        _persistanceTag = tag;
        _persistanceDict = dict;
        _manager = manager;
    }
    return self;
}
#pragma mark - extends methods

#pragma mark - public methods
//-(void)lockWithRefresh:(BOOL)isRefresh{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        persistancLock = [NSRecursiveLock new];
//    });
//    [persistancLock lock];
//    if (isRefresh) {
//        [self refresh];
//    }
//}
//
//-(void)unlockWithCommit:(BOOL)isCommit{
//    if(isCommit){
//        [self commit];
//    }
//    [persistancLock unlock];
//
//}

-(void)refresh{
    _persistanceDict = [_manager dictByClass:[self class] andTag:_persistanceTag];
}

-(void)remove{
    [_manager removeByPersistance:self];
    [self refresh];
}

-(void)commit{
    [_manager saveByPersistance:self];
}

-(NSString*)valueByName:(NSString*)name{
    return [_persistanceDict objectForKey:name];
}

#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods

+ (BOOL)resolveInstanceMethod:(SEL)selector
{
    NSString *selectorString = NSStringFromSelector(selector);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, selector, (IMP)autoDictionarySetter, "v@:@");
    } else {
        class_addMethod(self, selector, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

id autoDictionaryGetter(id self,SEL _cmd){
    NSString *key = NSStringFromSelector(_cmd);
    return [((RFPersistance*)self).persistanceDict objectForKey:key];
}

void autoDictionarySetter(id _self,SEL _cmd,id value){
    RFPersistance *self = (RFPersistance *)_self;
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key  = [selectorString mutableCopy];
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    if (value) {
        [self.persistanceDict setObject:value forKey:key];
    } else {
        [self.persistanceDict removeObjectForKey:key];
    }
}
@end
