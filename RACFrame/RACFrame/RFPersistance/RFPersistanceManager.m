//
//  RFPersistanceManager.m
//  RACFrame
//
//  Created by  rjt on 17/2/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFPersistanceManager.h"

@implementation RFPersistanceManager

+(instancetype)sharedInstace{
    static dispatch_once_t onceToken;
    static RFPersistanceManager* instance ;
    dispatch_once(&onceToken, ^{
        instance = [[RFPersistanceManager alloc] init];
    });
    
    return instance;
}

-(instancetype)init{
    if(self =[super init]){
        _userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *tmpdict = [_userDefaults dictionaryForKey:@"RFPersistanceManager"];
        if(tmpdict){
            _dict = [NSMutableDictionary dictionaryWithDictionary:tmpdict];
        }else{
            _dict = [NSMutableDictionary dictionary];
        }
    }
    return self;
}

-(NSMutableDictionary *)findDictionaryWithTag:(NSString *)tag{
    NSMutableDictionary *md = [_dict objectForKey:tag];
    if(md == nil){
        md = [NSMutableDictionary dictionary];
        [_dict setObject:md forKey:tag];
    }
    return md;
}

-(void)removeDictionaryWithTag:(NSString *)tag{
    [[_dict objectForKey:tag] removeAllObjects];
}

-(void)flush{
    NSLog(@"flush");
    NSMutableDictionary<NSString*,NSDictionary*> *retDict = [NSMutableDictionary dictionary];
    [_dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        [retDict setObject:[NSDictionary dictionaryWithDictionary:obj] forKey:key];
    }];
    [_userDefaults setObject:retDict forKey:@"RFPersistanceManager"];
    
    [_userDefaults synchronize];
}

@end
