//
//  SecuritycodePicParam.m
//  RACTest
//
//  Created by  rjt on 17/2/9.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "SecuritycodePicParam.h"

@implementation SecuritycodePicParam

-(NSString *)getPath{
    return @"/user/getsecuritycodePic";
}

-(RFNetWorkingRespSerializer)getResponseMode{
    return RFNetWorkingRespSerializerImage;
}

-(BOOL)isResultValid:(id)result error:(NSError *__autoreleasing *)error{
    if([result isKindOfClass:[UIImage class]]){
        return YES;
    }else{
        *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@",[self class]] code:kNetErrorUnexpectable userInfo:@{}];
        return NO;
    }
}

-(BOOL)isSilence{
    return YES;
}

@end
