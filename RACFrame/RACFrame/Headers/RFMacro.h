//
//  RFMacro.h
//  RACFrame
//
//  Created by  rjt on 17/1/22.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#ifndef RFMacro_h
#define RFMacro_h

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelWarning;
#endif

#define kGetMethod 1
#define kPostMethod 2

#define kRepeatInfinity -1

#endif /* RFMacro_h */
