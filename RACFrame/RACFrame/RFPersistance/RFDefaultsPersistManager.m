//
//  RFDefaultsPersistManager.m
//  RACFrame
//
//  Created by  rjt on 17/2/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFDefaultsPersistManager.h"

@implementation RFDefaultsPersistManager
#pragma mark - init methods
+(instancetype)sharedInstace{
    static dispatch_once_t onceToken;
    static RFDefaultsPersistManager* instance ;
    dispatch_once(&onceToken, ^{
        instance = [[RFDefaultsPersistManager alloc] init];
    });
    
    return instance;
}

-(instancetype)init{
    if(self =[super init]){
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

#pragma mark - extends methods
-(RFPersistance *)persistanceByClass:(Class)clss andTag:(NSString *)tag{
    NSMutableDictionary *retDict = [self dictByClass:clss andTag:tag];
    RFPersistance *p;
    if([clss isSubclassOfClass:[RFPersistance class]]){
        p = [[clss alloc] initWithDict:retDict andTag:tag andManager:self];
    }
    return p;
}

-(NSMutableDictionary *)dictByClass:(Class)clss andTag:(NSString *)tag{
    NSString *tagName = [NSString stringWithFormat:@"%@@@%@",[clss description],tag];
    NSDictionary *tmp = [_userDefaults objectForKey:tagName];
    NSMutableDictionary *retDict;
    if(tmp){
        retDict = [NSMutableDictionary dictionaryWithDictionary:tmp];
    }else{
        retDict = [NSMutableDictionary dictionary];
    }
    return retDict;
}

-(BOOL)saveByPersistance:(RFPersistance *)persistance{
    NSString *tagName = [NSString stringWithFormat:@"%@@@%@",[[persistance class] description],persistance.persistanceTag];
    [_userDefaults setObject:persistance.persistanceDict forKey:tagName];
    [_userDefaults synchronize];
    return YES;
}

-(BOOL)removeByPersistance:(RFPersistance *)persistance{
    NSString *tagName = [NSString stringWithFormat:@"%@@@%@",[[persistance class] description],persistance.persistanceTag];
    [_userDefaults removeObjectForKey:tagName];
    [_userDefaults synchronize];
    return YES;
}

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - delegate methods

#pragma mark - Action methods

@end

