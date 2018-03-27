//
//  CALayer_CAEmitterLayer.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/11.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CALayer_CAEmitterLayer.h"
#import "BaseHeader.h"

@interface CALayer_CAEmitterLayer ()

@end

@implementation CALayer_CAEmitterLayer

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CAEmitterLayer";
//    self.navigationController.navigationBar.hidden= NO;    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    //CherryViewController
    // =================== 背景图片 ===========================
    UIImageView * backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    backgroundView.image = [UIImage imageNamed:@"樱花树1"];
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundView];
    
    // =================== 樱花飘落 ====================
    CAEmitterLayer * snowEmitterLayer = [CAEmitterLayer layer];
    snowEmitterLayer.emitterPosition = CGPointMake(100, -30);
    snowEmitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    snowEmitterLayer.emitterMode = kCAEmitterLayerOutline;
    snowEmitterLayer.emitterShape = kCAEmitterLayerLine;
    //    snowEmitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell * snowCell = [CAEmitterCell emitterCell];
    snowCell.contents = (__bridge id)[UIImage imageNamed:@"樱花瓣2"].CGImage;
    
    // 花瓣缩放比例
    snowCell.scale = 0.02;
    snowCell.scaleRange = 0.5;
    
    // 每秒产生的花瓣数量
    snowCell.birthRate = 7;
    snowCell.lifetime = 80;
    
    // 秒速“五”厘米～～
    snowCell.velocity = 40;
    snowCell.velocityRange = 60;
    
    snowCell.alphaSpeed = -0.01;            // 每秒花瓣变透明的速度
    snowCell.emissionRange = M_PI;          // 花瓣掉落的角度范围
    snowCell.spin = M_PI_4;                 // 花瓣旋转的速度
    //snowCell.color = [Red_COLOR CGColor];   // 每个cell的颜色
    
    snowEmitterLayer.shadowOpacity= 1;                      // 阴影的 不透明 度
    snowEmitterLayer.shadowRadius = 8;                      // 阴影化开的程度（就像墨水滴在宣纸上化开那样）
    snowEmitterLayer.shadowOffset = CGSizeMake(3, 3);       // 阴影的偏移量
    snowEmitterLayer.shadowColor  = [White_COLOR CGColor];  // 阴影的颜色
    
    snowEmitterLayer.emitterCells = [NSArray arrayWithObject:snowCell];
    [backgroundView.layer addSublayer:snowEmitterLayer];
    
}


@end
