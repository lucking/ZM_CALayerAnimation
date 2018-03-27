//
//  CABasicAnimation_VC1.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/11.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CABasicAnimation_VC1.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"
#import "NSObject+CALayerAnimation.h"
#import "CALayerAnimationTools.h"


#define IsIOS7orAbove ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define kYOffset        (IsIOS7orAbove ? (44 + 20) : 0)

static CGFloat  yy1= 100,    yy2= 200,   yy3= 280,   yy4= 460,   yy5= 520,
                yy6= 600;

@interface CABasicAnimation_VC1 ()<CAAnimationDelegate>
{
    CALayer *scaleLayer;
    CALayer *moveLayer;
    CALayer *rotateLayer;
    CALayer *groupLayer;
}
@property (strong, nonatomic) UILabel *loginLab;
@property (strong, nonatomic) UIButton *scaleBtn;
@property (strong, nonatomic) UIButton *shakeBtn;
@property (strong, nonatomic) UIView *moveView;
@property (strong, nonatomic) UIView *moveView2;

@end


@implementation CABasicAnimation_VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CABasicAnimation_VC1";
    NSLog(@"--->kYOffset= %d",kYOffset);
    [self BaseUse];
    [self initGroupLayer];    
    [self createBtnTitle:@"放大效果" frame:CGRectMake(180, 80, 100, 100) tag:111];
    [self createBtnTitle:@"震动效果" frame:CGRectMake(160, 270, 100, 100) tag:222];

    [self CAKeyframeAnimation2];
}


/** CABasicAnimation
 *
 *  改变大小：transform.scale、scaleAnimation
 *  改变位置：position、moveAnimation
 *  围绕着x轴旋转：transform.rotation.x、rotateAnimation
 *  围绕着y轴旋转：transform.rotation.y、rotateAnimation
 *  围绕着z轴旋转：transform.rotation.z、rotateAnimation
 *
 *  多组动画同时演示：groupAnnimation
 *
 */
- (void)setLayer:(CALayer *)myLayer frame:(CGRect)frame bgColor:(UIColor *)bgColor cornerRadius:(CGFloat)radius {
    myLayer.backgroundColor = bgColor.CGColor;
    myLayer.frame           = frame;
    myLayer.cornerRadius    = radius;
}

- (void)BaseUse {
    
    /* 1: 改变大小
     * KeyPath： transform.scale
     * Key：     scaleAnimation
     */
    //1: 改变大小
    scaleLayer = [[CALayer alloc] init];
    [self setLayer:scaleLayer frame:CGRectMake(60, yy1, 50, 50) bgColor:Color_005DC3 cornerRadius:10];
    [self.view.layer addSublayer:scaleLayer];
    //设定动画效果
    [self setAnimationForLayer:scaleLayer keyPath:@"transform.scale" forKey:@"scaleAnimation"
                     fromValue:[NSNumber numberWithFloat:1.0]
                       toValue:[NSNumber numberWithFloat:0.5]
                  autoreverses:NO fillMode:kCAFillModeForwards repeatCount:MAXFLOAT
                      duration:0.8];

    
//    //如果是view 直接点调用他的图层 即可
//    UIView *myView = [UIView new];
//    //设定动画效果
//    [self setAnimationForLayer:myView.layer keyPath:@"transform.scale" forKey:@"scaleAnimation"
//                     fromValue:[NSNumber numberWithFloat:1.0]
//                       toValue:[NSNumber numberWithFloat:0.5]
//                  autoreverses:NO fillMode:kCAFillModeForwards repeatCount:MAXFLOAT
//                      duration:0.8];

    
    /* 2: 移动位置
     * KeyPath： position
     * Key：     moveAnimation
     */
    moveLayer = [[CALayer alloc] init];
    [self setLayer:moveLayer frame:CGRectMake(60, yy2, 50, 50) bgColor:Red_COLOR cornerRadius:10];
    [self.view.layer addSublayer:moveLayer];
    //设定动画效果
//    [self setAnimationForLayer:moveLayer keyPath:@"position" forKey:@"moveAnimation"
//                     fromValue:[NSValue valueWithCGPoint:moveLayer.position]
//                       toValue:[NSValue valueWithCGPoint:CGPointMake(60+150, moveLayer.position.y)]
//                  autoreverses:YES fillMode:kCAFillModeForwards repeatCount:MAXFLOAT
//                      duration:2];
    
    NSLog(@"---> yy2= %f", yy2);
    NSLog(@"---> yyy= %f", moveLayer.position.y);
    [self setAnimationForLayer:moveLayer keyPath:@"transform.translation" forKey:@"translationAnimation"
                     fromValue:[NSNumber numberWithFloat:0]
                       toValue:[NSNumber numberWithFloat:150]
                  autoreverses:YES fillMode:kCAFillModeForwards repeatCount:MAXFLOAT
                      duration:1.2];


    /* 3: 旋转
     * KeyPath： transform.rotation.y
     * Key：     rotateAnimation
     */
    rotateLayer = [[CALayer alloc] init];
    [self setLayer:rotateLayer frame:CGRectMake(60, yy3, 60, 60) bgColor:GreenColor cornerRadius:10];
    [self.view.layer addSublayer:rotateLayer];
    //设定动画效果
    [self setAnimationForLayer:rotateLayer keyPath:@"transform.rotation.y" forKey:@"rotateAnimation"
                     fromValue:[NSNumber numberWithFloat:0.0]
                       toValue:[NSNumber numberWithFloat:2.0 * M_PI]
                  autoreverses:YES fillMode:kCAFillModeForwards repeatCount:MAXFLOAT
                      duration:1];
    
}

/**
 *  4: 多组动画
 */
- (void)initGroupLayer
{
    //图层初始化
    groupLayer = [[CALayer alloc] init];
    groupLayer.frame = CGRectMake(20, yy4, 50, 50);
    groupLayer.cornerRadius = 10;
    groupLayer.backgroundColor = [[UIColor purpleColor] CGColor];
    [self.view.layer addSublayer:groupLayer];
    //设定动画效果_1：改变大小
    CABasicAnimation *scaleAnimation =
    [self setAnimationForKeyPath:@"transform.scale"
                       fromValue:[NSNumber numberWithFloat:1.0]
                         toValue:[NSNumber numberWithFloat:2.0]
                    autoreverses:YES repeatCount:MAXFLOAT duration:1.0];
    //设定动画效果_2：改变位置
    CABasicAnimation *moveAnimation =
    [self setAnimationForKeyPath:@"position"
                       fromValue:[NSValue valueWithCGPoint:groupLayer.position]
                         toValue:[NSValue valueWithCGPoint:CGPointMake(320-40, groupLayer.position.y)]
                    autoreverses:YES repeatCount:MAXFLOAT duration:2.0];
    //设定动画效果_3：旋转轴
    CABasicAnimation *rotateAnimation =
    [self setAnimationForKeyPath:@"transform.rotation.z"
                       fromValue:[NSNumber numberWithFloat:0.0]
                         toValue:[NSNumber numberWithFloat:4.0 * M_PI]
                    autoreverses:YES repeatCount:MAXFLOAT duration:2];

    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = YES;
    groupAnnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    groupAnnimation.repeatCount = MAXFLOAT;
    //开始动画
    [groupLayer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
    
    
    
    //创建要移动的视图_1
    _moveView = [UIView new];
    _moveView.backgroundColor = Cyan_COLOR;
    _moveView.frame = CGRectMake(20, yy5, 30, 30);
    [self.view addSubview:_moveView];
    //用法1​ Value方式
    //创建动画对象
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置value
    NSValue *value1= [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2= [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3= [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value4= [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue *value5= [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *value6= [NSValue valueWithCGPoint:CGPointMake(200, 400)];
    animation.values= @[value1,value2,value3,value4,value5,value6];
    animation.repeatCount= MAXFLOAT;
    animation.autoreverses = YES;
    //设置移动速度，越小越快
    animation.duration = 4.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate=self;
    //给这个view加上动画效果
    [_moveView.layer addAnimation:animation forKey:nil];
    
    // [self CAKeyframeAnimation1];

}

- (void)CAKeyframeAnimation2 {
    
    CGFloat Radius= 50;
    // （360°- 30°） ->（180°+30°） 逆时针的圆弧 CD圆弧
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, yy6)
                                                         radius:Radius
                                                     startAngle:22* M_PI - DegreesToRadians(30)
                                                       endAngle:M_PI + DegreesToRadians(30)
                                                      clockwise:NO];
    // （3/2π- 60°） ->（-1/2π -60°） 逆时针的圆 DD′圆
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100,yy6)
                                                         radius:Radius
                                                     startAngle:M_PI *3/2 - (M_PI_2 - DegreesToRadians(30))
                                                       endAngle:-M_PI_2 - (M_PI_2 -DegreesToRadians(30))
                                                      clockwise:NO];
    [path1 appendPath:path2];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    [self setCAShapeLayer:layer1 path:path1 strokeColor:Red_COLOR fillColor:Clear_COLOR lineWidth:5];
    [self setCAShapeLayer:layer2 path:path2 strokeColor:Yellow_COLOR fillColor:Clear_COLOR lineWidth:5];
    
    //方案
    CAKeyframeAnimation *startAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    [self setCAKeyframeAnimation:startAnimation
                          values:@[@0,@1]
                    functionName:kCAMediaTimingFunctionEaseOut
                        fillMode:kCAFillModeForwards
                        duration:2 repeatCount:100 removedOnCompletion:YES];
    
    CAKeyframeAnimation *EndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    [self setCAKeyframeAnimation:EndAnimation
                          values:@[@0,@1]
                    functionName:kCAMediaTimingFunctionEaseOut
                        fillMode:kCAFillModeForwards
                        duration:2 repeatCount:100 removedOnCompletion:YES];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:startAnimation,nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.duration = 3;
    animationGroup.repeatCount = 100;
    animationGroup.delegate = self;
    animationGroup.removedOnCompletion = 1;
    [animationGroup setValue:@"animationStep3" forKey:@"animationName"];
    
    [layer1 addAnimation:startAnimation forKey:nil];
    [layer2 addAnimation:EndAnimation forKey:nil];
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
}


/** CAKeyframeAnimation
 *
 */
- (void)BtnClick:(UIButton *)Btn {
    if (Btn.tag == 111) {
        // 放大
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        anim.repeatCount = 2;
        anim.values = @[@1.5, @1.0, @0.5, @1.0];
        [_scaleBtn.layer addAnimation:anim forKey:nil];
        
    }else if (Btn.tag == 222){
        // 发抖
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 2;
        anim.duration = 0.2;
        anim.values = @[@-10, @10, @-10];
        [_shakeBtn.layer addAnimation:anim forKey:nil];
    }
}


/**
 设定效果，添加动画
 
 @param myLayer 动画的图层
 @param keyPath 动画特征
 @param forKey  动画效果
 @param fromValue       原位置
 @param toValue         结果位置
 @param autoreverses    设置是否原路返回，默认为不
 @param fillMode    填充模式
 @param repeatCount 重复次数 （默认为1、无限循环：MAXFLOAT）
 @param duration    动画持续的时间
 @return 返回动画
 */
- (CABasicAnimation *)setAnimationForLayer:(CALayer *)myLayer
                                   keyPath:(NSString *)keyPath forKey:(NSString *)forKey
                                 fromValue:(id)fromValue       toValue:(id)toValue
                              autoreverses:(BOOL)autoreverses
                                  fillMode:(NSString *)fillMode
                               repeatCount:(float)repeatCount
                                  duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue   = toValue;
    animation.autoreverses  = autoreverses;
    animation.fillMode      = fillMode;
    animation.repeatCount   = repeatCount;
    animation.duration      = duration;
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //开始动画
    [myLayer addAnimation:animation forKey:forKey];
    return animation;
}
//设定效果：多组动画使用
- (CABasicAnimation *)setAnimationForKeyPath:(NSString *)keyPath
                                   fromValue:(id)fromValue      toValue:(id)toValue
                                autoreverses:(BOOL)autoreverses repeatCount:(float)repeatCount
                                    duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue   = toValue;
    animation.autoreverses  = autoreverses;
    animation.repeatCount   = repeatCount;
    animation.duration      = duration;
    return animation;
}

- (void)createBtnTitle:(NSString *)title frame:(CGRect)frame tag:(int)tag {
    
    UIButton* Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame= frame;
    Btn.titleLabel.font = FFont(16);
    [Btn setTitleColor:[UIColor colorWithWhite:0.246 alpha:1.000] forState:UIControlStateNormal];
    [Btn setTitle:title forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    Btn.tag = tag;
    [self.view addSubview:Btn];
    
    if (tag==111) {
        [Btn setBackgroundImage:IMG(@"0.png") forState:UIControlStateNormal];
        self.scaleBtn = Btn;
    }else if (tag==222){
        Btn.backgroundColor = Orange_CC;
        self.shakeBtn= Btn;
    }
    
}

- (void)CAKeyframeAnimation1 {
    //    //创建要移动的视图_2
    //    _moveView2 = [UIView new];
    //    _moveView2.backgroundColor = Color_CDDC39;
    //    _moveView2.frame = CGRectMake(20, yy6, 30, 30);
    //    [self.view addSubview:_moveView2];
    //    //用法2​  Path方式
    //    //创建动画对象
    //    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //    //创建一个CGPathRef对象，就是动画的路线
    //    CGMutablePathRef path = CGPathCreateMutable();
    //
    //    //自动沿着弧度移动
    //    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 200, 200, 100));
    //    //设置开始位置
    //    CGPathMoveToPoint(path,NULL,100,100);
    //    //沿着直线移动
    //    CGPathAddLineToPoint(path,NULL, 200, 100);
    //    CGPathAddLineToPoint(path,NULL, 200, 200);
    //    CGPathAddLineToPoint(path,NULL, 100, 200);
    //    CGPathAddLineToPoint(path,NULL, 100, 300);
    //    CGPathAddLineToPoint(path,NULL, 200, 400);
    //    //沿着曲线移动
    //    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
    //    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
    //    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
    //    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
    //
    //    animation2.path=path;
    //    CGPathRelease(path);
    //
    //    animation2.autoreverses = YES;
    //    animation2.repeatCount= MAXFLOAT;
    //    animation2.removedOnCompletion = NO;
    //    animation2.fillMode = kCAFillModeForwards;
    //    animation2.duration = 4.0f;
    //    animation2.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    animation2.delegate=self;
    //    [_moveView2.layer addAnimation:animation2 forKey:nil];
    
}

@end
