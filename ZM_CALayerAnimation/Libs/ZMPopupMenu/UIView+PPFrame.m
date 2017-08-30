//
//  UIView+PPFrame.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "UIView+PPFrame.h"

@implementation UIView (PPFrame)
// Category理论上不能添加变量，但是可以使用@dynamic 来弥补这种不足。
@dynamic lab;
@dynamic minX;
@dynamic maxX;
@dynamic centerX;

@dynamic minY;
@dynamic maxY;
@dynamic centerY;


/**
 *   xx
 */
- (CGFloat)minX		{	return CGRectGetMinX(self.frame);	}
- (CGFloat)maxX		{	return CGRectGetMaxX(self.frame);	}
- (CGFloat)centerX	{	return self.center.x;				}
/**
 *   yy
 */
- (CGFloat)minY		{	return CGRectGetMinY(self.frame);	}
- (CGFloat)maxY		{	return CGRectGetMaxY(self.frame);	}
- (CGFloat)centerY	{	return self.center.y;				}
/**
 *  基本参数
 */
- (CGFloat)x		{	return self.frame.origin.x;			}
- (CGFloat)y		{	return self.frame.origin.y;			}
- (CGFloat)width	{   return CGRectGetWidth(self.frame);  } // self.frame.size.width;
- (CGFloat)height	{   return CGRectGetHeight(self.frame); } // self.frame.size.height;
- (CGPoint)origin	{   return self.frame.origin;           }
- (CGSize)size		{   return self.frame.size;             }
- (CGFloat)left		{	return self.frame.origin.x;	}
- (CGFloat)top		{	return self.frame.origin.y; }
- (CGFloat)right	{	return self.frame.origin.x + self.frame.size.width;	}
- (CGFloat)bottom	{	return self.frame.origin.y + self.frame.size.height;}
/**
 *  移除所有子视图
 */
- (void)removeAllSubview{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


//- (void)setMaxX:(CGFloat)maxX {
//	CGRect frame = self.frame;
//	frame.origin.x = maxX - frame.size.width;
//	self.frame = frame;
//}
- (void)setMinX:(CGFloat)minX {
    CGRect frame = self.frame;
    frame.origin.x = minX;
    self.frame = frame;
}


// xx
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
// yy
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
// width
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
// height
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

// origin
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
// size
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


// 左边：Left
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
// 上边：Top
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
// 右边：Right
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}// 下边：Bottom
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

@end
