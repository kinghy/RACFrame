//
//  RFPersistance.m
//  RACFrame
//
//  Created by  rjt on 17/2/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFPersistance.h"
#import <objc/runtime.h>

@implementation RFPersistance

@dynamic persistanceTag;

-(instancetype)init{
    if(self=[super init]){
        _persistanceDict = [NSMutableDictionary dictionary];
    }
    return self;
}

-(instancetype)initWithTag:(NSString *)tag{
    if(self=[super init]){
        self.persistanceTag = tag;//必须这样写
    }
    return self;
}

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
