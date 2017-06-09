//
//  AdEntity.h
//  A50
//
//  Created by  rjt on 15/10/19.
//  Copyright © 2015年 JYZD. All rights reserved.
//

@interface AdEntity : NSObject<IRFEntity>
@property (strong,nonatomic) NSArray* records;
@end

@interface AdRecordsEntity : NSObject<IRFEntity>
@property (strong,nonatomic) NSString* title;	//广告title	string
@property (strong,nonatomic) NSString* pic;	//图片地址	string
@property (strong,nonatomic) NSString* link;	//链接URL	string
@property (strong,nonatomic) NSString* create_time;	//时间	int
@property (strong,nonatomic) NSString* iscert;
@end
