//
//  RFPersistanceManager.h
//  RACFrame
//
//  Created by  rjt on 17/2/10.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFPersistanceManager : NSObject{
    NSUserDefaults *_userDefaults;
    
    NSMutableDictionary<NSString*,NSMutableDictionary*> *_dict;
}


+(instancetype)sharedInstace;

-(NSMutableDictionary*)findDictionaryWithTag:(NSString*)tag;
-(void)removeDictionaryWithTag:(NSString*)tag;

-(void)flush;

@end
