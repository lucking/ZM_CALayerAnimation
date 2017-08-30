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

@interface PopupMenuVC ()
@property (nonatomic, strong)ZMPopupMenuView *popupMenuView;

@end

@implementation PopupMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化UI
    [self createUI];
    
//    [self.view addSubview:self.popupMenuView];
//    self.popupMenuView.hidden = YES;

    _popupMenuView = [[ZMPopupMenuView alloc]initWithFrame:CGRectMake(150, 200, 150,260)];
//    _popupMenuView.backgroundColor = Yellow_COLOR;
}
- (void)dealloc {
    [_popupMenuView removeFromSuperview];
    _popupMenuView = nil;
}

//// 弹出列表
//- (ZMPopupMenuView *)popupMenuView {
//    if (!_popupMenuView) {
//        _popupMenuView = [[ZMPopupMenuView alloc]initWithFrame:CGRectMake(20, 200, 150,200)];
//        _popupMenuView.backgroundColor = Yellow_COLOR;
//    }
//    return _popupMenuView;
//}

//例一：显示
- (void)case1 {
    //self.popupMenuView.hidden = NO;
    
    [self.popupMenuView show];
}
//例二：隐藏
- (void)case2 {
//    self.popupMenuView.hidden = YES;
    [self.popupMenuView dismiss];

}
//例三：
- (void)case3 {}
//例四：
- (void)case4 {}
//例五：
- (void)case5 {}
//例六：
- (void)case6 {}
//例七：
- (void)case7 {}
//例八：
- (void)case8 {}
//例九：
- (void)case9 {}


- (void)createUI {
    
    NSString *title=@"";
    CGFloat width = 120;
    for (int i=1 ; i<6; i++) {
        title = [NSString stringWithFormat:@"case%d",i];
        if (i==1) { title= @"显示";}
        if (i==2) { title= @"隐藏";}
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

@end
