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

-(BOOL)saveByPersistanceArray:(NSArray<RFPersistance*> *)persistances{
    [_fmdb beginTransaction];
    for(RFPersistance* p in persistances){
        NSString *table = [[p class] description];
        NSArray *propertyArray = [p getPropertyNames];
        [self checkTableByName:table andPropertyNames:propertyArray];
        NSMutableString *str = [NSMutableString string];
        [str appendString:@"INSERT INTO temp "];
        NSMutableString *strColumn = [NSMutableString stringWithString:@"("];
        NSMutableString *strValue = [NSMutableString stringWithString:@"VALUES("];
        for(int i=0; i < [propertyArray count];++i){
            NSString *property = propertyArray[i];
            if(![[property lowercaseString] isEqualToString:@"id"]){
                123123
            }
            @"INSERT INTO temp (stock_code,stock_name,stock_abbr,code_shsz,shsz,stock_kind) VALUES(?,?,?,?,?,?)",obj[@"code"],obj[@"name"],obj[@"abbr"],obj[@"code_shsz"],obj[@"shsz"],obj[@"stock_kind"]];
        }
        [strColumn appendString:@")"];
        [strValue appendString:@")"];
        

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
