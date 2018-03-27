//
//  CAAnimation_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/12.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CAAnimation_VC.h"
#import "BaseHeader.h"
#import "CALayerAnimationTools.h"

@interface CAAnimation_VC ()
{
    CALayer *mylayer;
    CALayer *shadowLayer;
    BOOL use;
}
@end

@implementation CAAnimation_VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CAAnimation_VC";
    self.view.layer.cornerRadius=60;
    self.view.layer.backgroundColor = [UIColor yellowColor].CGColor;
    
    [self initUI];
    [self createUI];
}

- (void)createUI {
    mylayer=[CALayer layer];
    mylayer.frame=CGRectMake(170, 80, 80, 80);
    mylayer.backgroundColor=[UIColor cyanColor].CGColor;
    mylayer.borderWidth=2;
    mylayer.borderColor=[UIColor whiteColor].CGColor;
    mylayer.cornerRadius=40;
    mylayer.masksToBounds=YES;
    //mylayer.opacity=0.2;     //1.5设置透明度
    [self.view.layer addSublayer:mylayer];

    //2.阴影图层
    shadowLayer=[[CALayer alloc]init];
    shadowLayer.frame= CGRectMake(260, 80, 80, 80); // mylayer.frame
//    shadowLayer.frame= mylayer.frame;
    shadowLayer.backgroundColor= OrangeColorAA.CGColor;
    shadowLayer.cornerRadius = 40;
    //shadowLayer.masksToBounds=YES; //会裁掉阴影
    shadowLayer.shadowColor  = [UIColor greenColor].CGColor;
    shadowLayer.shadowOpacity= 0.9;
    shadowLayer.shadowRadius = 10;
    shadowLayer.shadowOffset = CGSizeMake(0, 6);
    [self.view.layer addSublayer:shadowLayer];

    
//    self.view2.layer.shadowOpacity = 0.8;
//    let path = CGPathCreateMutable();
//    //画一个圆形的阴影        
//    CGPathAddArc(path, nil, 200, 200, 20, 0, CGFloat(M_PI*2), true);
//    self.view2.layer.shadowPath = path;
    

}
//例一：layer透明
- (void)case1 {
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    if (use==NO) {  mylayer.opacity=0.1;
    } else{         mylayer.opacity=1.0;
    }
    [CATransaction commit];
    use= !use;
}
//例二：layer变换7种颜色
- (void)case2 {
    
    [mylayer setContents:(id)[UIImage imageNamed:@""].CGImage];
    
    CAKeyframeAnimation *colorkey=[CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    colorkey.values= [NSArray arrayWithObjects:
                      (id)[UIColor cyanColor].CGColor,
                      (id)[UIColor redColor].CGColor,
                      (id)[UIColor greenColor].CGColor,
                      (id)[UIColor brownColor].CGColor,
                      (id)[UIColor blueColor].CGColor,
                      (id)[UIColor yellowColor].CGColor,
                      (id)[UIColor purpleColor].CGColor,nil];
    colorkey.duration=3;
    [mylayer addAnimation:colorkey forKey:nil];

}

//例三：用过度效果，添加一张图片(圆形翻转)
- (void)case3 {
   
    if (use==NO) {
        CATransition *tranAn=[CATransition animation];
        tranAn.duration=1;
        tranAn.type= SuckEffect;
        
        [mylayer setContents:(id)[UIImage imageNamed:@"m0.jpg"].CGImage];
        [mylayer addAnimation:tranAn forKey:nil];
        
        shadowLayer.position=   mylayer.position;
        [shadowLayer addAnimation:tranAn forKey:nil];
    }else{
        [mylayer setContents:(id)[UIImage imageNamed:@""].CGImage];
    }
    use= !use;
}

//例四：一边移动 一边放大 一边旋转
- (void)case4 {
    //4.1 多方向移动
//    CAKeyframeAnimation *keyPosition=[CAKeyframeAnimation animationWithKeyPath:@"position"];
//    keyPosition.duration= 4; //整体动画的持续时间
//    NSValue *value1=[NSValue valueWithCGPoint:mylayer.position];
//    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(220, 120)]; //0.8s
//    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(220, 260)]; //(3.2-0.8)= 2.4s
//    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(30, 380)];  //(4-3.2)=   0.8s
//    //关键帧value和time对应，第一个就开始时间，运动到下一个地址的时间。（时间比）
//    keyPosition.values=[NSArray arrayWithObjects:value1,value2,value3,value4, nil];
//    keyPosition.keyTimes= [NSArray arrayWithObjects:
//                           [NSNumber numberWithFloat:0],
//                           [NSNumber numberWithFloat:0.2],
//                           [NSNumber numberWithFloat:0.8],
//                           [NSNumber numberWithFloat:1] ,nil];
//    [mylayer addAnimation:keyPosition forKey:nil];
    
    //4.1 上下移动：CABasicAnimation
    CABasicAnimation *basic1=[CABasicAnimation animationWithKeyPath:@"position"];
    basic1.duration=2;
    basic1.fromValue= [NSValue valueWithCGPoint:mylayer.position];
    basic1.toValue  = [NSValue valueWithCGPoint:CGPointMake(mylayer.position.x, mylayer.position.y+200)];
    basic1.autoreverses=YES; //自动恢复 原位
  
    //4.2 旋转：CABasicAnimation
    CABasicAnimation *basic2=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basic2.byValue=[NSNumber numberWithFloat: 4* M_PI]; //旋转720度
    basic2.duration= 2;
    basic2.autoreverses=YES;
   
    //4.3 变大：CABasicAnimation
    CABasicAnimation *basic3=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basic3.duration= 2;
    basic3.toValue= [NSNumber numberWithFloat:2]; // 变大2倍
    basic3.autoreverses=YES;
    
    //4.4 翻转：CATransition
    CATransition *tran= [CATransition animation];
    tran.duration=2;
    tran.type= RippleEffect;
    [mylayer setContents:(id)[UIImage imageNamed:@"m1.jpg"].CGImage];
    
    shadowLayer.position= mylayer.position;
    [shadowLayer addAnimation:basic1 forKey:nil];
    [shadowLayer addAnimation:basic2 forKey:nil];
    [shadowLayer addAnimation:basic3 forKey:nil];
    //[shadowLayer addAnimation:tran forKey:nil];

    // 动画组：添加多个动画
    //[mylayer addAnimation:tran forKey:nil];
    //[mylayer addAnimation:basic1 forKey:nil];
    //[mylayer addAnimation:basic2 forKey:nil];
    //[mylayer addAnimation:basic3 forKey:nil];
    // 4.5 动画组  ( CAAnimationGroup )
    CAAnimationGroup *group=[CAAnimationGroup animation];
    group.animations = [NSArray arrayWithObjects:basic1,basic2,basic3,tran, nil];
    group.duration   = 5;
    group.removedOnCompletion= NO;
    group.fillMode= kCAFillModeForwards;  //充满模式、填充模式
    group.fillMode= kCAFillModeRemoved;   //恢复 到原来的位置
    [mylayer addAnimation:group forKey:nil];

}

//例五： CATransition：（水波抖动）
- (void)case5 {
   
    CATransition *tranAn=[CATransition animation];
    tranAn.duration=1;
    tranAn.type= RippleEffect;
    [mylayer setContents:(id)[UIImage imageNamed:@"scene1.png"].CGImage];
    [mylayer addAnimation:tranAn forKey:nil];
}

//例六：CATransition：（翻转）
- (void)case6 {
    
    CATransition *tranAn=[CATransition animation];
    tranAn.duration=1;
    tranAn.type= OglFlip;
    [mylayer setContents:(id)[UIImage imageNamed:@"scene2.png"].CGImage];
    [mylayer addAnimation:tranAn forKey:nil];
}

//例七：
- (void)case7 {
    
}
//例八：
- (void)case8 {
    
}
//例九：
- (void)case9 {
    
}

- (void)initUI {
    NSString *title=@"";
    CGFloat width = 150;
    for (int i=1 ; i<11; i++) {
        title = [NSString stringWithFormat:@"case%d",i];
        if (i==1) { title= @"1.layer透明";  }
        if (i==2) { title= @"2.变换7种颜色";  }
        if (i==3) { title= @"3.添加一张图片";  }
        if (i==4) { title= @"4.移动_放大_旋转";  }
        if (i==5) { title= @"5.水波抖动";  }
        if (i==6) { title= @"6.翻转";  }

        [self addBtnTitle:title frame:CGRectMake(10, 50+ (35+10)*i, width, 35) Tag:i];
    }
}
- (void)myBtnClick:(UIButton *)Btn{
    if (Btn.tag==1) {       [self case1];
    }else if (Btn.tag==2) { [self case2];
    }else if (Btn.tag==3) { [self case3];
    }else if (Btn.tag==4) { [self case4];
    }else if (Btn.tag==5) { [self case5];
    }else if (Btn.tag==6) { [self case6];
    }else if (Btn.tag==7) { [self case7];
    }else if (Btn.tag==8) { [self case8];
    }else if (Btn.tag==9) { [self case9];
    }
}


@end
