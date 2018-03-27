//
//  UIView+ZMBrokenLine.h
//  ZM_CALayerAnimation
//
//  Created by ZM on 2018/3/27.
//  Copyright © 2018年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZMBrokenLine)
{
    
}
@property (nonatomic,strong) UILabel* lab;

// 自己模仿frame写出他的四个属性
@property (nonatomic, assign) CGFloat  x;
@property (nonatomic, assign) CGFloat  y;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;

@property (nonatomic, assign) CGPoint  origin;
@property (nonatomic, assign) CGSize   size;


@property (nonatomic, assign) CGFloat  minX;
@property (nonatomic, assign) CGFloat  maxX;
@property (nonatomic, assign) CGFloat  centerX;

@property (nonatomic, assign) CGFloat  minY;
@property (nonatomic, assign) CGFloat  maxY;
@property (nonatomic, assign) CGFloat  centerY;


@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height


-(void)removeAllSubview;
@end
