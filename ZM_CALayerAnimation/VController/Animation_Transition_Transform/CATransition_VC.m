//
//  CATransition_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/7.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CATransition_VC.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"
#import "CAHeader.h"

@interface CATransition_VC ()
{
    BOOL isflage;
    CALayer *myLayer;
    UIImageView *imgView;
    UIButton *button;
}
@property (weak, nonatomic) UIImageView *imageView;
@property (retain, nonatomic) NSArray *urlArray;
@end

@implementation CATransition_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ThreeVC";
    // 初始化UI
    [self initUI];
    
    //创建UI
    [self createUIView];
    
    
    
}

//创建UI
-(void)createUIView
{
    
    myLayer=[CALayer layer];
    myLayer.frame=CGRectMake(150, 80, 130, 120);
    myLayer.backgroundColor=[UIColor cyanColor].CGColor;
    myLayer.borderWidth = 1;
    myLayer.borderColor = Orange_CC.CGColor;
    [self.view.layer addSublayer:myLayer];
    
    
    UIImage *image = [UIImage imageNamed:@"scene1"];
    button = [[UIButton alloc] initWithFrame:CGRectMake(200, 220, 100, 100)];
    button.backgroundColor = Yellow_COLOR;
    [button addTarget:self action:@selector(BtnTransition) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 333;
    [button.layer setContents:(id)image.CGImage];
    //button.layer.contents = (__bridge id _Nullable)(image.CGImage); //同上
    [self.view addSubview:button];
    
    
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(170, 260, 100, 100)];
    imgView.backgroundColor = Magenta_COLOR;
    //    imgView.alpha = 0.2;
    [self.view addSubview:imgView];
    
    
}

- (void)transition6 {
    
    CATransition *tranAn=[CATransition animation];
    tranAn.duration=1;
    tranAn.type= OglFlip; // oglFlip 上下翻转
    
    UIImage *image=[UIImage imageNamed:@"scene2"];
    [myLayer setContents:(id) image.CGImage];
    [myLayer addAnimation:tranAn forKey:nil];
    myLayer.contents = (__bridge id _Nullable)(image.CGImage);
}

- (void)BtnTransition {
    
    CATransition *tranAn=[CATransition animation];
    tranAn.duration =1;
    tranAn.type = RippleEffect; //rippleEffect 水波抖动
    [button.layer addAnimation:tranAn forKey:nil];
    
}


//例一：
- (void)case1 {
    [self transition6];

}
//例二：
- (void)case2 {
    [self BtnTransition];

}
//例三：
- (void)case3 {
    
}
//例四：
- (void)case4 {
    
}
//例五：
- (void)case5 {
    
}
//例六：
- (void)case6 {
    
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
    CGFloat width = 120;
    for (int i=1 ; i<11; i++) {
        title = [NSString stringWithFormat:@"case%d",i];
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

#pragma mark - onClick
//触摸时：隐藏导航条
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    isflage=!isflage;
    [super.navigationController setNavigationBarHidden:isflage animated:TRUE];
    [super.navigationController setToolbarHidden:isflage animated:TRUE];
}



@end
