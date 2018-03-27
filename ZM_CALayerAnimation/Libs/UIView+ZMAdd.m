//
//  UIView+ZMAdd.m
//  ZMArchitecture
//
//  Created by ZM on 16/5/11.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import "UIView+ZMAdd.h"
#import "BaseHeader.h"

@implementation UIView (ZMAdd)

- (void)Use_test {
    
    
    UIView *view1;
    [self flipView:view1 Rect:CGRectMake(0, 0, SSWIDTH, SSHEIGHT) forView:self timeInterval:0.1];
    
    
    UILabel *_myLab1;
    // 设置各个圆角
    [self setCornersOfView:_myLab1 byCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
               cornerRadii:CGSizeMake(10,10)
                 fillColor:Purple_CD69C9
                 lineWidth:10
                 lineColor:Clear_COLOR];
    
    // 设置阴影
    [self setshadowOfView:_myLab1
             shadowOffset:CGSizeMake(-6, 6)
              shadowColor:[UIColor greenColor]
            shadowOpacity:0.3
             shadowRadius:2];
    
    
//    // 设置段落样式
//    [_myLab1 seteLineSpace:0 paragraphSpace:0 characterSpace:[NSNumber numberWithFloat:5] alignment:NSTextAlignmentCenter headIndent:5];
    
    
    //画虚线  （  在此方法中使用  - (void)drawRect:(CGRect)rect   ）
    CGFloat dashArray3[] = {2, 3};
    [self drawDashLineOfDashArray:dashArray3
                       startPoint:CGPointMake(5, 200)
                         endPoint:CGPointMake(305, 200) lineWidth:2 lineColor:Orange_AA ];
}


/**
 设置

 @param cornerRadius 圆弧半径
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
-(void)cornerRadius:(CGFloat)cornerRadius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
{
    self.layer.cornerRadius= cornerRadius;
    self.layer.masksToBounds= YES;
    self.layer.borderWidth= borderWidth;
    self.layer.borderColor= borderColor.CGColor;
}

/**
 设置view的四个边角圆弧
 
 @param myView  要设置的View
 @param corners 不同的角度
 @param radii   每个角的半径.
 @param fillColor 内部颜色（注意：myView.backgroundColor= 设为透明色，用fillColor代替背景色）
 @param lineWidth 边线宽度
 @param lineColor 边线颜色
 */
- (void)setCornersOfView:(UIView *)myView
               byCorners:(UIRectCorner)corners
             cornerRadii:(CGSize)radii
               fillColor:(UIColor *)fillColor
               lineWidth:(CGFloat )lineWidth
               lineColor:(UIColor *)lineColor {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:myView.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:radii];
    CAShapeLayer *shapeLayer= [CAShapeLayer layer];
    shapeLayer.fillColor    = fillColor.CGColor;
    shapeLayer.strokeColor  = lineColor.CGColor;
    shapeLayer.lineWidth    = lineWidth;
    shapeLayer.lineJoin     = kCALineJoinRound;
    shapeLayer.lineCap      = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [myView.layer addSublayer:shapeLayer];
}


/**
 阴影设置：shadow
 
 @param myView  主视图
 @param shadowOffset  阴影偏移
 @param shadowColor   阴影颜色
 @param shadowOpacity 阴影透明度
 @param shadowRadius  阴影角弧度
 */
- (void)setshadowOfView:(UIView *)myView
           shadowOffset:(CGSize)shadowOffset
            shadowColor:(UIColor *)shadowColor
          shadowOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
{
    myView.layer.shadowOffset = shadowOffset;
    myView.layer.shadowColor  = shadowColor.CGColor;
    myView.layer.shadowOpacity= shadowOpacity;
    myView.layer.shadowRadius = shadowRadius;
}


/**
 画虚线
 
 @param dashArray 虚线间隙数组
 @param startPoint  开始点 坐标
 @param endPoint    结束点 坐标
 @param lineWidth 线宽
 @param lineColor 线颜色
 */
- (void)drawDashLineOfDashArray:(const CGFloat * __nullable)dashArray
                     startPoint:(CGPoint)startPoint
                       endPoint:(CGPoint)endPoint
                      lineWidth:(CGFloat)lineWidth
                      lineColor:(UIColor *)lineColor {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(ctx, 0, dashArray, 2);
    CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
}



#pragma mark 导航视图 动画
- (void)pushViewController:(UIViewController *)nav
{
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    window.rootViewController= nav;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;    //从底部滑入
    //nav.modalPresentationStyle =  UIModalPresentationFullScreen;
    [UIView commitAnimations];
}


#pragma mark 普通动画
- (void)flipView:(UIView *)myView
           Rect:(CGRect)myRect
        forView:(UIView *)view
   timeInterval:(NSTimeInterval)durationTime
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:durationTime];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:view cache:YES];
    myView.frame = myRect;
    [UIView commitAnimations];
    
}



// 动画 (模仿系统方法)
- (void)animationDuration:(NSTimeInterval)duration animation:(void (^)(void) )animationBlock {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self cache:YES];

    animationBlock();
    
    [UIView commitAnimations];
}

// 翻页动画
- (void)animationDuration:(NSTimeInterval)duration transition:(UIViewAnimationTransition)transition curve:(UIViewAnimationCurve)curve animation:(void (^)(void) )animationBlock  {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:window cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    animationBlock();
    
    [UIView commitAnimations];
}

// 系统方法
- (void)aaa {
    
    //1.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 内容
    [UIView commitAnimations];
    
    
    //2.
    [UIView animateWithDuration:0.3 animations:^{
        
    }];
    
    //3.
    [UIView animateWithDuration:0.3 animations:^{
        
    } completion:^(BOOL finished) {
    }];
    
    //4. 起始时间和持续时间值在0.0和1.0之间指定时间和持续时间相对于整体的关键帧动画
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
        
    } completion:^(BOOL finished) {
    }];
    
    //5.
    [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:^(BOOL finished) {
    }];
    
    //6.
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.0f initialSpringVelocity:0.0f options:0 animations:^{
        
    } completion:^(BOOL finished) {
    }];
}

/**
 *
 1.常规动画属性设置（可以同时选择多个进行设置）
 
	UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
	UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
	UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
 
	UIViewAnimationOptionRepeat：重复运行动画。
	UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
	UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
	UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
	UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
 
	UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
	UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
 
 2.动画速度控制（可从其中选择一个设置）
 
	UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
	UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
	UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
	UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
 
 3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
 
	UIViewAnimationOptionTransitionNone：没有转场动画效果。
	UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
	UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
	UIViewAnimationOptionTransitionCurlUp：			向后翻页的动画过渡效果。
	UIViewAnimationOptionTransitionCurlDown ：		向前翻页的动画过渡效果。
 
	UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
	UIViewAnimationOptionTransitionFlipFromTop ：  从上方翻转效果。
	UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
 */


@end
