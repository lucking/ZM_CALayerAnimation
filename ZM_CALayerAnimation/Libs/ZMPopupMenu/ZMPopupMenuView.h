//
//  ZMPopupMenuView.h
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

// 枚举三:hump
typedef NS_ENUM(NSInteger,HumpType) {
    TopHumpMode,
    LeftHumpMode,
    RightHumpMode,
    BottomHumpMode
};
@class ZMPopupMenuView;
@protocol ZMPopupMenuViewDelegate <NSObject>
@optional
/**
 点击事件回调
 */
- (void)popupMenuView:(ZMPopupMenuView *)popupMenuView didSelectItemAtIndex:(NSInteger)index;
@end


@interface ZMPopupMenuView : UIView
{
    
}
// 凸起方向
@property (nonatomic, assign) HumpType humpType;
// 设置字体颜色 Default is [UIColor blackColor]
@property (nonatomic, strong) UIColor * textColor;
// 设置字体大小 Default is 15
@property (nonatomic, assign) CGFloat fontSize;
// 点击菜单外消失  Default is YES
@property (nonatomic, assign) BOOL dismissOnTouchOutside;
// 是否显示阴影 Default is YES
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;

// item的高度 Default is 44;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *fillColor;

@property (nonatomic, weak) id <ZMPopupMenuViewDelegate> delegate;



- (ZMPopupMenuView *)showRelyOnView:(UIView *)view
                             titles:(NSArray *)titles
                              icons:(NSArray *)icons
                          menuWidth:(CGFloat)itemWidth
                           delegate:(id<ZMPopupMenuViewDelegate>)delegate;

- (void)setTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray;

//展示
- (void)show;
//隐藏
- (void)dismiss;
//置空
- (void)removeAndSetNil;

@end
