//
//  ZMPopupMenuView.h
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPopupMenuView : UIView
{
    
}
/**
 设置字体颜色 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor * textColor;
/**
 设置字体大小 Default is 15
 */
@property (nonatomic, assign) CGFloat fontSize;


/**
 item的高度 Default is 44;
 */
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat itemWidth;


- (void)show;
- (void)dismiss;


@end
