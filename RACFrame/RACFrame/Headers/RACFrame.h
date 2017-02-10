//
//  RACFrame.h
//  RACFrame
//
//  Created by  rjt on 17/1/19.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#ifndef RACFrame_h
#define RACFrame_h

#import <UIKit/UIKit.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "RFMacro.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <OpenUDID/OpenUDID.h>

//AOP框架
#import "RFAspect.h"
#import "RFAspectsManager.h"
#import "RFAspectsManager+AppDelegate.h"
#import "RFAspectsManager+Controller.h"


//网络框架
#import "RFNetAdapter.h"

//本地持久化框架
//#import "RFPersistance.h"

//工具
#import "NSString+MD5.h"
#import "NSString+SHA1.h"
#import <Toast/UIView+Toast.h>
#import <SDWebImage/SDWebImageDownloader.h>

//UIView扩展
#import "UIView+RFKeyBoard.h"
#import "UITextField+RFKeyBoard.h"
#import "UIView+HUD.h"

#endif /* RACFrame_h */
