//
//  RFDBPersistManager.m
//  RACFrame
//
//  Created by  rjt on 17/4/13.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFDBPersistManager.h"
#import <FMDB/FMDB.h>

@implementation RFDBPersistManager
#pragma mark - init methods
+(instancetype)sharedInstace{
    static dispatch_once_t onceToken;
    static RFDBPersistManager* instance ;
    dispatch_once(&onceToken, ^{
        instance = [[RFDBPersistManager alloc] init];
    });
    
    return instance;
}

-(instancetype)init{
    if(self =[super init]){
        
        NSString *documentFile = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _documents = documentFile;
        NSString *path = [documentFile stringByAppendingPathComponent:@"productdb.db"];
        
        _fmdb = [[FMDatabase alloc]initWithPath:path];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        _tableDict = [NSMutableDictionary dictionary];
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


-(NSArray<RFPersistance*>*)persistancesByClass:(Class)clss andQuery:(NSString*)query{
    NSMutableArray<RFPersistance*>* array = [NSMutableArray<RFPersistance*> array];
    if(query.length>0){
        RFPersistance *p = [clss new];
        NSString *str = [NSString stringWithFormat:@"select %@ from %@ where %@",[[p getPropertyNames] componentsJoinedByString:@","],[clss description],query];
        [_fmdb open];
        FMResultSet *set = [_fmdb executeQuery:str];
        
        while ([set next]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for(NSString *key in [set resultDictionary].allKeys){
                NSString *value = [NSString stringWithFormat:@"%@",[[set resultDictionary] objectForKey:key]];
                NSString *keyNew = [key isEqualToString:@"id"]?@"ID":key;
                [dict setObject:value forKey:keyNew];
            }
            RFPersistance *p = [[clss alloc] initWithDict:dict andTag:[clss description] andManager:self];
            [array addObject:p];
        }
        [_fmdb close];
    }
    return array;
}

-(NSMutableDictionary *)dictByClass:(Class)clss andTag:(NSString *)tag{
    return [NSMutableDictionary dictionary];
}

-(BOOL)saveByPersistanceArray:(NSArray<RFPersistance*> *)persistances{
    [_fmdb beginTransaction];
    for(RFPersistance* p in persistances){
        NSString *table = [[p class] description];
        NSArray *propertyArray = [p getPropertyNames];
        [self checkTableByName:table andPropertyNames:propertyArray];
        NSMutableString *str = [NSMutableString string];
        [str appendFormat:@"INSERT INTO %@ ",table];
        NSMutableString *strColumn = [NSMutableString stringWithString:@"("];
        NSMutableString *strValue = [NSMutableString stringWithString:@" VALUES("];
        for(int i=0; i < [propertyArray count];++i){
            NSString *property = propertyArray[i];
            if(![[property lowercaseString] isEqualToString:@"id"] && [p valueByName:property]){
                if(strColumn.length>1){
                    [strColumn appendString:@","];
                    [strValue appendString:@","];
                }
                [strColumn appendFormat:@"%@",property];
                [strValue appendFormat:@"\"%@\"",[p valueByName:property]];
            }
        }
        [strColumn appendString:@")"];
        [strValue appendString:@")"];
        [str appendString:strColumn];
        [str appendString:strValue];
//        NSLog(str);
        [_fmdb executeUpdate:str];
        
    }
    [_fmdb commit];
    return YES;
}

#pragma mark - public methods

#pragma mark - private methods
-(BOOL)checkTableByName:(NSString*)tableName andPropertyNames:(NSArray*)properties{
    NSNumber* n = [_tableDict objectForKey:tableName];
    if(!n || !n.boolValue){
        [_fmdb open];
        if([_fmdb tableExists:tableName]){
            [_tableDict setObject:[NSNumber numberWithBool:YES] forKey:tableName];
            return YES;
        }else if(properties && properties.count>0){
            NSMutableString *str = [NSMutableString string];
            [str appendFormat:@"create table if not exists %@ (id integer primary key autoincrement",tableName];
            for(NSString *tmpstr in properties){
                if(![[tmpstr lowercaseString] isEqualToString:@"id"]){
                    [str appendFormat:@",%@ text(255)",tmpstr];
                }
            }
            [str appendFormat:@")"];
            
            if (![_fmdb executeUpdate:str]) {
                DDLogError(@"创建表失败");
                return NO;
            }
            [_tableDict setObject:[NSNumber numberWithBool:YES] forKey:tableName];
            return YES;
        }else{
            return NO;
        }
        
        [_fmdb close];
    }else{
        return YES;
    }
}

#pragma mark - delegate methods

#pragma mark - Action methods

#pragma mark - get/set methods


@end
