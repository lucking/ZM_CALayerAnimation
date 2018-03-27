//
//  CABasicAnimation_VC2.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/11.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CABasicAnimation_VC2.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"


@interface CABasicAnimation_VC2 ()<CAAnimationDelegate>
{
    CALayer *mylayer1;
    UIImageView* _imgView;
}
@end

@implementation CABasicAnimation_VC2



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Animation_layer";
    self.title = @"CABasicAnimation_VC2";
    CGFloat yy = 80;
    CGFloat width = 160;
    //左：按钮
    [self addBtnTitle:@"开始旋转" frame:CGRectMake(6, yy, width, 35) Tag:1];
    [self addBtnTitle:@"暂停"    frame:CGRectMake(6, yy+45*1, width, 35) Tag:2];
    [self addBtnTitle:@"继续"    frame:CGRectMake(6, yy+45*2, width, 35) Tag:3];
    //右：按钮
    [self addBtnTitle:@"放大"     frame:CGRectMake(10*2+width, yy, width, 35) Tag:6];
    [self addBtnTitle:@"放大缩小"  frame:CGRectMake(10*2+width, yy+45*1, width, 35) Tag:7];
    
    [self createView];
    
}

- (void)createView
{
    // 图片：测试缩小放大动画
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 300, 60, 60)];
    _imgView.backgroundColor = Color_CDDC39;
    _imgView.image = [UIImage imageNamed:@"BANK_CMB"];
    [self.view addSubview:_imgView];
    
    
    // 测试旋转的图层
    float width = 100;
    mylayer1 = [CALayer layer];
    mylayer1.frame = CGRectMake(180, 300, width, width);
    mylayer1.backgroundColor = [UIColor clearColor].CGColor;
    mylayer1.cornerRadius = width/2;   //设置圆角半径
    mylayer1.masksToBounds= YES;
    //my_layer.position = CGPointMake(60, 120);
    UIImage *image= [UIImage imageNamed:@"0.png"];
    [mylayer1 setContents:(id) image.CGImage];
    [self.view.layer addSublayer:mylayer1];
    
    
    //图片的中心 与 图层的中心重合
    // ImgView.center = my_layer.position;
    
}
-(void)myBtnClick:(UIButton *)Btn{
    
    if (Btn.tag == 1) {
        // 旋转一周(2* M_PI)、用时2秒、1倍速率、循环一次
        [self addAnimationCALayer:mylayer1 forKeyPath:@"transform.rotation" byValue:[NSNumber numberWithFloat: 2*M_PI]autoreverses:NO repeatCount:1 speed:1 beginTime:5 duration:2];
        
        // 旋转一周(2* M_PI)、用时2秒、2倍速率
        [self addAnimationCALayer:mylayer1 forKeyPath:@"transform.rotation"
                          byValue:[NSNumber numberWithFloat: 2*M_PI]
                     autoreverses:NO repeatCount:MAXFLOAT speed:2 beginTime:0 duration:2];
        
    }else if (Btn.tag == 2){
        [self pauseLayer:mylayer1];     //暂停
        
    }else if (Btn.tag == 3){
        [self continueLayer:mylayer1];  //继续
        
    }else if (Btn.tag == 6){
        [self changeBigSmall:_imgView.layer toValue:2];
        
    }else if (Btn.tag == 7){
        [self changeBigSmall:_imgView.layer toValue:0.3];
        
    }

}


// 2.暂停_layer上的动画
- (void)pauseLayer:(CALayer*)layer{
    
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
    NSLog(@"pausedTime1 = %f",pausedTime);
}
// 3.继续_layer上的动画
- (void)continueLayer:(CALayer*)layer {
    
    CFTimeInterval pausedTime = [layer timeOffset]; //获取上次暂停的时间
    layer.speed = 1.0;
    layer.timeOffset= 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
    NSLog(@"timeSincePause2 = %f \n ",timeSincePause);
}

#pragma mark 放大缩小动画
-(void)changeBigSmall:(CALayer*)mylayer toValue:(float)toValue{
    CABasicAnimation *Animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    Animation.duration= 1.2;
    Animation.fromValue= [NSNumber numberWithFloat:1.0];    // 开始时的倍率
    Animation.toValue  = [NSNumber numberWithFloat:toValue];// 结束时的倍率
    Animation.delegate = self;
    [mylayer addAnimation:Animation forKey:@"scale-layer"];
}


#pragma mark ======================"  CAAnimationDelegate 动画代理  "==============================
/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    NSLog(@"--> animation_DidStart");
}
/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"animation_DidStop");
    //ImgView.frame = CGRectMake(ImgView.x, ImgView.y, ImgView.width*2, ImgView.height*2);
}

/**
 设定效果，添加动画
 
 @param layer    动画的图层
 @param keyPath  动画特征
 @param byValue  动画过程值
 @param autoreverses 设置是否原路返回默认为不
 @param repeatCount  重复次数（默认为1、无限循环_MAXFLOAT）
 @param speed        动画速度（默认为1）
 @param beginTime    动画开始时间 （默认为0，测试了，好像没有作用）
 @param duration     动画持续的时间
 @return 返回动画
 */
- (CABasicAnimation *)addAnimationCALayer:(CALayer*)layer forKeyPath:(NSString *)keyPath
                                  byValue:(id)byValue
                             autoreverses:(BOOL)autoreverses
                              repeatCount:(float)repeatCount
                                    speed:(float)speed
                                beginTime:(CFTimeInterval)beginTime
                                 duration:(CFTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.byValue = byValue;
    animation.autoreverses  = autoreverses;
    animation.repeatCount   = repeatCount;
    animation.speed         = speed;        //每一圈旋转速度的倍数
    //animation.beginTime      = beginTime;
    layer.beginTime = beginTime;
    animation.duration      = duration;
    [layer addAnimation:animation forKey:nil];
    return animation;
}



@end
