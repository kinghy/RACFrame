//
//  AppColorMacro.h
//  RACTest
//
//  Created by  rjt on 17/2/15.
//  Copyright © 2017年 JYZD. All rights reserved.
//

#ifndef AppColorMacro_h
#define AppColorMacro_h

// 自定义RGB色值
#define Color_Bg_RGB(x, y, z) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:1.0f]
#define Color_Bg_RGBA(x, y, z,a) [UIColor colorWithRed:x/255.0f green:y/255.0f blue:z/255.0f alpha:a]

//按钮蓝颜色
#define kBtnBlueColor Color_Bg_RGB(49,121,255)
#define kBtnDisabledColor Color_Bg_RGB(224, 224, 224)
#define kBtnTextDisabledColor Color_Bg_RGB(190, 190, 190)
//文字灰色
#define kTextGrayColor Color_Bg_RGB(139,139,139)
#define kTextMainColor Color_Bg_RGB(34.0f, 34.0f,  34.0f) //一级文字
#define kTextSecondColor Color_Bg_RGB(117.0f, 117.0f, 117.0f)//二级文字
#define kTextThirdColor Color_Bg_RGB(171.0f, 171.0f, 171.0f)//三级文字

#define kLastOrangeColor Color_Bg_RGB(255,126,0)

//列表、VC背景颜色
#define kTableBgColor Color_Bg_RGB(249,249,249)

//列表分割线颜色
#define kSplitLineColor Color_Bg_RGB(240,240,240)
//涨红
#define kUpRedColor Color_Bg_RGB(252,47,59)
//跌绿
#define kDownGreenColor Color_Bg_RGB(27,192,125)
//平灰
#define kFlatGrayColor Color_Bg_RGB(166.0f,165.0f, 170.0f)//灰色

#define kLoginHeadBG Color_Bg_RGB(209.f,209.f,209.f)

#define kBgShadowColor Color_Bg_RGBA(0, 0, 0, 0.8)


#endif /* AppColorMacro_h */
