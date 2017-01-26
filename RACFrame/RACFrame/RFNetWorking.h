//
//  RFNetWorking.h
//  RACFrame
//
//  Created by  rjt on 17/1/11.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RFNetWorking : NSObject
+(instancetype)netWorking;

-(RACSignal*)postWithUrl:(NSString*)url andHeaders:(NSDictionary*)headers andParams:(NSDictionary*)params andTimeOut:(int)timeOut;
-(RACSignal*)getWithUrl:(NSString*)url andHeaders:(NSDictionary*)headers andParams:(NSDictionary*)params andTimeOut:(int)timeOut;
@end
