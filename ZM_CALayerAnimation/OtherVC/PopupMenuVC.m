//
//  PopupMenuVC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "PopupMenuVC.h"
#import "ZMPopupMenuView.h"
#import "BaseHeader.h"

@interface PopupMenuVC ()<ZMPopupMenuViewDelegate>
@property (nonatomic, strong)ZMPopupMenuView *popupMenuView;
@end

@implementation PopupMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化UI
    [self createUI];
    //@[@"m0.jpg",@"m1.jpg",@"scene1.png",@"scene2.png",@"scene13.jpg"]
    //_popupMenuView.backgroundColor = Yellow_COLOR;
    
    [self setPopupMenuView];
}
- (void)dealloc {
    //置空    
    [_popupMenuView removeAndSetNil];
    _popupMenuView = nil;
}
#pragma mark ======================"  ZMPopupMenuViewDelegate  "==============================
#pragma mark
- (void)popupMenuView:(ZMPopupMenuView *)popupMenuView didSelectItemAtIndex:(NSInteger)index;
{
    NSLog(@"index= %ld",index);

}

- (void)setPopupMenuView {
    _popupMenuView = [[ZMPopupMenuView alloc]initWithFrame:CGRectMake(150, 200, 100,200)];
    _popupMenuView.delegate = self;
    _popupMenuView.humpType = LeftHumpMode;
    [_popupMenuView setTitleArray:@[@"1分",@"5分",@"15分",@"30分",@"60分"] imageArray:nil];
}


//例一：显示
- (void)case1 {
    [self.popupMenuView show];
}
//例二：隐藏（内部点击可以隐藏，此处只展示代码，用不到）
- (void)case2 {
    [self.popupMenuView dismiss];
}
//例三：
- (void)case3Btn:(UIButton *)Btn {
    [self.popupMenuView show];    _popupMenuView.humpType = TopHumpMode;
}
//例四：
- (void)case4Btn:(UIButton *)Btn  {
   [self.popupMenuView show];     _popupMenuView.humpType = BottomHumpMode;
}
//例五：
- (void)case5Btn:(UIButton *)Btn  {
    [self.popupMenuView show];    _popupMenuView.humpType = LeftHumpMode;
}
//例六：
- (void)case6Btn:(UIButton *)Btn  {
    [self.popupMenuView show];    _popupMenuView.humpType = RightHumpMode;
}
//例七：
- (void)case7 {}
//例八：
- (void)case8 {}
//例九：
- (void)case9 {}


- (void)createUI {
    
    NSString *title=@"";
    CGFloat width = 120;
    for (int i=1 ; i<7; i++) {
        title = [NSString stringWithFormat:@"case%d",i];
        if (i==1) { title= @"显示";}
        if (i==2) { title= @"隐藏";}
        if (i==3) { title= @"上凸";}
        if (i==4) { title= @"下凸";}
        if (i==5) { title= @"左凸";}
        if (i==6) { title= @"右凸";}
        [self addBtnTitle:title frame:CGRectMake(10, 50+ (35+10)*i, width, 35) Tag:i];
    }
}
- (void)myBtnClick:(UIButton *)Btn {
    if (Btn.tag==1) {       [self case1];
    }else if (Btn.tag==2) { [self case2];
    }else if (Btn.tag==3) { [self case3Btn:Btn];
    }else if (Btn.tag==4) { [self case4Btn:Btn];
    }else if (Btn.tag==5) { [self case5Btn:Btn];
    }else if (Btn.tag==6) { [self case6Btn:Btn];
    }else if (Btn.tag==7) { [self case7];
    }else if (Btn.tag==8) { [self case8];
    }else if (Btn.tag==9) { [self case9];
    }
}
#pragma mark - onClick
//触摸时：
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"-->touchesBegan：开始触摸");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-->touchesMoved：开始移动");
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-->touchesEnded：移动结束");
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"-->touchesCancelled：触摸结束");
}

#pragma mark ---------"  公共部分 "------------
#pragma mark - Orientation是否支持转屏
- (BOOL)shouldAutorotate{
    return NO;
}
#pragma mark -  支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;//UIInterfaceOrientationMaskLandscape
}
#pragma mark -默认的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}

//// 弹出列表
//- (ZMPopupMenuView *)popupMenuView {
//    if (!_popupMenuView) {
//        _popupMenuView = [[ZMPopupMenuView alloc]initWithFrame:CGRectMake(20, 200, 150,200)];
//        _popupMenuView.backgroundColor = Yellow_COLOR;
//    }
//    return _popupMenuView;
//}

// self.popupMenuView.hidden = NO;
// self.popupMenuView.hidden = YES;


@end
