//
//  CABasicAnimation_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CABasicAnimation_VC.h"
#import "CABasicAnimation_VC1.h"
#import "CABasicAnimation_VC2.h"

@interface CABasicAnimation_VC ()

@end

@implementation CABasicAnimation_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];

}

- (void)createUI {
    CGFloat yy = 80;
    CGFloat width = 170;
    [self addBtnTitle:@"CABasicAnimation_VC1" frame:CGRectMake(10, yy, width, 35) Tag:111];
    [self addBtnTitle:@"CABasicAnimation_VC2" frame:CGRectMake(10*2+width, yy, width, 35) Tag:222];
    [self addBtnTitle:@"333" frame:CGRectMake(10, yy+45, width, 35) Tag:333];
}
- (void)myBtnClick:(UIButton *)Btn{
    if (Btn.tag==111) {
        CABasicAnimation_VC1 *pushVC = [[CABasicAnimation_VC1 alloc]init];
        [self.navigationController pushViewController:pushVC animated:YES];
    }else if (Btn.tag==222) {
        CABasicAnimation_VC2 *pushVC = [[CABasicAnimation_VC2 alloc]init];
        [self.navigationController pushViewController:pushVC animated:YES];
        
    }else if (Btn.tag==333) {
    }
}
@end
