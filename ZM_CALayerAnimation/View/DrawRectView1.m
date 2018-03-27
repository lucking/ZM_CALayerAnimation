//
//  DrawRectView1.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/10/7.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "DrawRectView1.h"

@interface DrawRectView1()
{
}
@property (nonatomic, strong) UIView *BgView;
@property (nonatomic, strong) UILabel *label;
@end



@implementation DrawRectView1

//从代码中加载：初始化不设置大小
- (instancetype)init {
    self= [super init];
    if (self) {
        [self commonInit];// 公共初始化方法
    }
    return self;
}
//从代码中加载：初始化设置大小
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        [self commonInit];// 公共初始化方法
    }
    return self;
}
//从文件中加载
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self){
        [self commonInit];// 公共初始化方法
    }
    return self;
}

#pragma mark 公共初始化方法
- (void)commonInit {
    // setter getter UI
}
#pragma mark 绘图
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myFrame = self.bounds;
    CGContextSetLineWidth(context, 10);
    [[UIColor redColor] set];
    UIRectFrame(myFrame);
    
    self.opaque = YES;
    self.clearsContextBeforeDrawing = NO;

}
#pragma mark 尺寸
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize fitSize = [super sizeThatFits:size];
    //fitSize.height += self.label.frame.size.height;
    //如果是固定尺寸，就像UISwtich那样返回一个固定Size就OK了
    return fitSize;
}

/*
 awakeFromNib方法里就不要再去调用commonInit了。
 
 如果您能确定自己的描画代码总是以不透明的内容覆盖整个视图的表面,则可以将视图的opaque属性声明设置为YES,以提高描画代码的总体效率。当您将视图标识为不透明时,UIKit会避免对该视图正下方的内容进行描画。这不仅减少了描画开销的时间,而且减少内容合成需要的工作。然而,只有当您能确定视图提供的内容为不透明时,才能将这个属性设置为YES;如果您不能保证视图内容总是不透明,则应该将它设置为NO。
 
 提高描画性能(特别是在滚动过程)的另一个方法是将视图的clearsContextBeforeDrawing属性设置为NO。当这个属性被设置为YES时,UIKIt会在调用drawRect:方法之前,把即将被该方法更新的区域填充为透明的黑色。将这个属性设置为NO可以取消相应的填充操作,而由应用程序负责完全重画传给drawRect:方法的更新矩形中的部分。这样的优化在滚动过程中通常是一个好的折衷。

 
 */

@end
