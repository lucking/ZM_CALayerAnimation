//
//  ZMPopupMenuHeader.h
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#ifndef ZMPopupMenuHeader_h
#define ZMPopupMenuHeader_h



//获取当前系统的版本号
//#define FLOATVALUE [[[UIDevice currentDevice] systemVersion] floatValue]

//------------------"  手机尺寸类型  "---------------
////isRetina
//#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
////iPhone5
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
////Pad
//#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//
//#define  IS_IPHONE45    (([[UIScreen mainScreen] bounds].size.width-320)?NO:YES)
//#define  IS_IPHONE4    (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)
//#define  IS_IPHONE5    (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
//#define  IS_IPHONE6    (([[UIScreen mainScreen] bounds].size.width-375)?NO:YES)
//#define  IS_IPHONE6p   (([[UIScreen mainScreen] bounds].size.width-414)?NO:YES)


//------------------"  尺寸  "---------------
// 屏幕bounds
#define PPScreenBounds [UIScreen mainScreen].bounds
// 屏幕的size
#define PPScreenSize [UIScreen mainScreen].bounds.size
//宽度、高度
#define PPWIDTH     ([UIScreen mainScreen].bounds.size.width)
#define PPHEIGHT    ([UIScreen mainScreen].bounds.size.height)
#define PPKeyWindow [UIApplication sharedApplication].keyWindow

//字体大小
#define PPFont(font)			[UIFont systemFontOfSize:font]
#define PPBoldFont(font)	[UIFont boldSystemFontOfSize:font]
#define PPItalicFont(font)	[UIFont italicSystemFontOfSize:font]

#define PPHelveticaFont(font)		[UIFont fontWithName:@"Helvetica" size:font];
#define PPHelveticaBoldFont(font)	[UIFont fontWithName:@"Helvetica-Bold" size:font];


//======================="  UIImage  "=================================

#define  PPIMG(imageName)  [UIImage imageNamed:imageName]


//======================="  UIColor  "=================================

#define PPColorWithRGB(r,g,b)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.0f]
#define PPColorWithRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]
// 十六进制颜色
#define PPColor_With_Hex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
// 调用
//UIColor *redColor = Color_With_Hex(0xe4e5e5);
//#define     Clear_COLOR         [UIColor clearColor]    // 透明色
//#define     White_COLOR         [UIColor whiteColor]    // 白色
//#define     Black_COLOR         [UIColor blackColor]    // 黑色
//#define     Gray_COLOR			[UIColor grayColor]     // 灰色
//#define     LightGray_COLOR     [UIColor lightGrayColor]// 亮灰色
//
//#define     Red_COLOR			[UIColor redColor]      // 红色
//#define     Cyan_COLOR			[UIColor cyanColor]     // 靛蓝
//#define     Magenta_COLOR       [UIColor magentaColor]  // 磁红
//#define     Yellow_COLOR		[UIColor yellowColor]   // 黄色
//#define     OrangeColor         [UIColor orangeColor]   // 橙色
//#define     Brown_Color         [UIColor brownColor]    // 棕色
//#define     Purple_Color        [UIColor purpleColor]   // 紫色
//#define     Green_Color         [UIColor greenColor]    // 绿色
//#define     Blue_Color          [UIColor blueColor]     // 蓝色


//---------------------"  蓝、绿   "-------------------
//// 蓝色
//#define BuleColorAA     UIColorWithRGB(3,91,166)
//#define BuleColor_BB    UIColorWithRGB(2,117,219)
////浅浅淡淡蓝色
//#define     Color_XXXXXX    UIColorWithRGB(216,236,253)
////淡蓝色 //导航栏
//#define     Color_70AEE1    UIColorWithRGB(112,174,225)
//#define     Color_005DC3    UIColorWithRGB(0,93,195)    //蓝色
//#define     Blue_2599FA     UIColorWithRGB(37,153,250)  //浅蓝色
//#define     Blue_3C96F5     UIColorWithRGB(60,150,225)  //蓝
//#define     Blue_59A2E3     UIColorWithRGB(89,162,227)  //背景
//#define     Bule_5CACEE     Color_With_Hex(0x5CACEE)
//#define     Bule_20B2AA     Color_With_Hex(0x20B2AA)
//
//
//// 标准绿色
//#define GreenColor      UIColorWithRGB(5,111,0)
//// 绿色
//#define GreenColorAA    UIColorWithRGB(90,220,80)
//#define Green_00CD66    Color_With_Hex(0x00CD66)
//#define Green698B69     Color_With_Hex(0x698B69)
//#define Green5F9EA0     Color_With_Hex(0x5F9EA0)
//#define Green_9BCD9B    Color_With_Hex(0x9BCD9B) //浅绿：0x9BCD9B、0x8FBC8F
//#define Green_96CDCD    Color_With_Hex(0x96CDCD) //浅蓝绿


//---------------------"  红、粉、紫   "-------------------
//#define Red_EEAEEE      Color_With_Hex(0xEEAEEE) //粉紫
//#define Purple_AB82FF   Color_With_Hex(0xAB82FF) //淡紫
//#define Purple_CD69C9   Color_With_Hex(0xCD69C9) //淡紫





//---------------------"   橙色、黄色   "-------------------
// 导航栏
//#define	 NavBg_COLOR			UIColorWithRGB(255,120,2)
//#define	 NavBg_COLOR			UIColorWithRGB(33,150,243)
////
//#define  Orange_ff7800			UIColorWithRGB(255,120,0)
//#define  Orange_AA				UIColorWithRGB(255,187,6)
//#define  Orange_BB				UIColorWithRGB(255,180,70)
//#define  Orange_CC				UIColorWithRGB(240,155,5)   // 深橙色
//#define  OrangeColorAA			UIColorWithRGB(243,157,3)   // 橙色


////TabBar按钮
//#define Color_normal     UIColorWithRGB(149,149,149) //默认：标题颜色
//#define Color_select     UIColorWithRGB(255,152,0)   //选中：标题颜色
//#define Color_tabBar     UIColorWithRGB(239,239,239) //tabBar颜色
//
//
////背景
////淡灰色
//#define  BgColor				UIColorWithRGB(238,243,249)
//#define  BgLightColor			UIColorWithRGB(250,250,250)
//#define  BgGrayColor			UIColorWithRGB(240,240,240)
//#define  BgGrayColorAA			UIColorWithRGB(223,223,223)
//#define  BgGrayColorBB			UIColorWithRGB(206,206,206)
//#define  BgGrayColorCC			UIColorWithRGB(189,189,189)
////
//#define  GrayColor_Text			UIColorWithRGB(245,245,245)
//#define  GrayColor_titView		UIColorWithRGB(220,220,220)
////
//#define  GrayColor_Login		UIColorWithRGB(177,177,177)
//#define  GrayColor_Login1		UIColorWithRGB(200,200,200)


//---------------------"  分割线  "---------------------
////浅灰
//#define     Gray_eeeeee     UIColorWithRGB(238,238,238)
////常用
//#define     Gray_dddddd     UIColorWithRGB(221,221,221)
//#define     Gray_cccccc     UIColorWithRGB(204,204,204)
////深灰
//#define     Gray_bbbbbb     UIColorWithRGB(187,187,187)
//#define     Gray_aaaaaa     UIColorWithRGB(170,170,170)
////大边线
//#define     Gray_adb4b9     UIColorWithRGB(173,180,185)
//#define     Gray_ADB4B9     UIColorWithRGB(173,180,185)
//#define     Gray_eef3f9     UIColorWithRGB(238,240,249)
////线条淡灰
//#define     grayline        UIColorWithRGB(201,201,201)
//
///**
// *	蒙板
// */
//#define     CoverColor      UIColorWithRGB(150,150,150)

//---------------------"  字体颜色  "-------------------
////灰黑色字体
//#define ziti_Color      UIColorWithRGB(31,28,28)
////标题字
//#define  Gray_222222        UIColorWithRGB(34,34,34)
//#define  Gray_333333        UIColorWithRGB(51,51,51)
//#define  Gray_444444        UIColorWithRGB(68,68,68)
////突出字
//#define  Gray_555555        UIColorWithRGB(85,85,85)
//#define  Gray_666666        UIColorWithRGB(102,102,102)
////内容字
//#define  Gray_888888        UIColorWithRGB(136,136,136)
//#define  Gray_999999        UIColorWithRGB(160,160,160)
////#define  Gray_AAAAAA        UIColorWithRGB(170,170,170)
//#define  Gray_BBBBBB        UIColorWithRGB(187,187,187)
//#define  Gray_CCCCCC        UIColorWithRGB(203,203,203)
//
////浅灰色
//#define Gray_808080    UIColorWithRGB(128,128,128)
////淡灰色
//#define Gray_909090    UIColorWithRGB(144,144,144)
////淡浅灰色 #f0f0f0
//#define     Color_f0f0f0    UIColorWithRGB(240,240,240)
////灰色
//#define     gray_Color      UIColorWithRGB(249,249,249)



/************"  部分Material Design的配色颜色值规范  "*************/

//#define Color_F44336   UIColorWithRGB(244,67,54)    //红色   #F44336
//#define Color_E91E63   UIColorWithRGB(233,30,99)    //深红   #E91E63
//#define Color_9C27B0   UIColorWithRGB(156,39,176)   //紫色   #9C27B0
//#define Color_673AB7   UIColorWithRGB(103,58,183)   //深紫   #673AB7
//
//#define Color_3F51B5   UIColorWithRGB(63,81,181)    //湛蓝   #3F51B5
//#define Color_2196F3   UIColorWithRGB(33,150,243)   //深蓝   #2196F3
//#define Color_03A9F4   UIColorWithRGB(3,169,244)    //蓝色   #03A9F4
//#define Color_00BCD4   UIColorWithRGB(0,188,212)    //浅蓝   #00BCD4
//
//#define Color_009988   UIColorWithRGB(0,150,136)    //深绿   #009988
//#define Color_5AB963   UIColorWithRGB(90,185,99)    //绿色   #5AB963
//#define Color_8BC34A   UIColorWithRGB(139,195,74)   //浅绿   #8BC34A
//#define Color_CDDC39   UIColorWithRGB(205,220,57)   //黄绿   #CDDC39
//
//#define Color_FFEB3B   UIColorWithRGB(255,235,59)   //浅黄   #FFEB3B
//#define Color_FFC107   UIColorWithRGB(255,193,7)    //黄色   #FFC107
//#define Color_FF9800  UIColorWithRGB(255,152,0)     //橘黄   #FF9800
//#define Color_FF5722   UIColorWithRGB(255,87,34)    //浅红   #FF5722


//
////--------"  AlertView  "-----------
//#define     AlertView(mmessage)    UIAlertView* AlertView =  [[UIAlertView alloc]initWithTitle:@"温馨提示" message:mmessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];\
//[AlertView show]
//
//
//
////NSLog 分割线    //使用  NSLog(@"----->:%@",message);
//#define NSLogline(format, ...) do {      \
//fprintf(stderr,  "<%s : %d> %s\n" ,  \
//[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
//__LINE__, __func__);                                                        \
//(NSLog)((format), ##__VA_ARGS__);                                                   \
//fprintf(stderr,  " -------------------------------完美分割线---------------------------------- \n  \n " );          \
//} while ( 0 )
//
//
//#define NSSLogline(format, ...) do {      \
//fprintf(stderr,  " -------------------------------完美分割线---------------------------------- \n  \n" );          \
//} while ( 0 )
//
//
//// DEBUG 模式
//#if DEBUG
//#define NSSLog(...) NSLog(__VA_ARGS__)
//#else
//#define NSSLog(...) nil
//#endif
//
//// 我推荐用这个打印我们的日志: 功能、行数
//#ifdef DEBUG
//#define NSLogLINE(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLogLINE(...)
//#endif
//
//// 可以输出 纯净的内容：NSLog去掉时间戳及其他输出样式
//#ifdef DEBUG
//#define NNSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NNSLog(...)
//#endif




#endif /* ZMPopupMenuHeader_h */
