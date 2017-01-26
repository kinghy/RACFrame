//
//  RFAspectsManager+Controller.h
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#import "RFAspectsManager.h"

/**
 ViewController切片接口
 */
@protocol RFControllerAspectInt <NSObject>
@optional
-(void)after_viewDidLoad:(id)instance;
@end

@interface RFAspectsManager (Controller)
-(void)installControler;
@end
