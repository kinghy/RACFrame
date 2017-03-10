//
//  SetEntity.h
//  RACTest
//
//  Created by  rjt on 17/2/28.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetEntity : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *titleImg;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic) int tag;
@property (nonatomic) bool bottomLineShow;
@property (nonatomic) float bottomLineIndent;
@property (nonatomic) bool topLineShow;
@property (nonatomic) float topLineIndent;

@end
