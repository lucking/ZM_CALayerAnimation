//
//  ZMPopupMenuView.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ZMPopupMenuView.h"
#import "UIView+PPFrame.h"
#import "ZMPopupMenuHeader.h"
#import "PopupMenuCell.h"

@interface ZMPopupMenuView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UILabel   *titleLab;
@property (nonatomic, strong) UIView    *maskView;
/**
 点击菜单外消失  Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnTouchOutside;
/**
 是否显示阴影 Default is YES
 */
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;
@property (nonatomic, assign) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UITableView * ttableView;
@end

@implementation ZMPopupMenuView

- (instancetype)init {
    self = [super init];
    if (self){
        [self initUI];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        [self initUI];
    }
    return self;
}

//初始化UI
- (void)initUI {
//    self.layer.cornerRadius = 5.0f;
    //self.clipsToBounds = YES;
//    self.layer.borderWidth = 1.f;
//    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self setCornersOfView];
    self.alpha = 1;
    self.backgroundColor = [UIColor clearColor];

    [self addSubview:self.titleLab];
    [self addSubview:self.ttableView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
    [self.maskView addGestureRecognizer: tap];
    
    self.dismissOnTouchOutside = YES;
    self.isShowShadow = YES;
    self.ttableView.frame = CGRectMake(0, 10, self.width, self.height-10);
   // self.titleLab.text = @"PopupMenuView";
    
}
//创建UI
- (void)createUI {
    [PPKeyWindow addSubview:self.maskView];
    [PPKeyWindow addSubview:self];
}
- (void)touchOutSide
{
    if (_dismissOnTouchOutside) {
        [self dismiss];
    }
}
//显示
- (void)show {
    
    [PPKeyWindow addSubview:self.maskView];
    [PPKeyWindow addSubview:self];
    
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
        _maskView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}
//隐藏
- (void)dismiss {
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
        _maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_maskView removeFromSuperview];
    }];
}

- (void)drawRect:(CGRect)rect {
    [self drawLine];
}
// 画线：UIBezierPath
- (void)drawLine {
    
    //三角凸起
    NSLog(@"---> self.centerX = %f\n ",self.centerX);    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(self.width/2-10, 0)];     // 起点
    [linePath addLineToPoint:CGPointMake(self.width/2, -10)];   // 第2个点
    [linePath addLineToPoint:CGPointMake(self.width/2+10, 0)];  // 第3个点
    //同上（使用图层填充）
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor magentaColor].CGColor;
    lineLayer.fillColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:lineLayer];
    //覆盖三角空心处
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    [linePath2 moveToPoint:CGPointMake(self.width/2-10+1, 0)];     // 起点
    [linePath2 addLineToPoint:CGPointMake(self.width/2+10-1, 0)];  // 第2个点
    CAShapeLayer *lineLayer2 = [CAShapeLayer layer];
    lineLayer2.path = linePath2.CGPath;
    lineLayer2.lineWidth = 1;
    lineLayer2.strokeColor = [UIColor yellowColor].CGColor;
    lineLayer2.fillColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:lineLayer2];
}


#pragma mark ======================"  tableViewDelegate && dataSource  "==============================
#pragma mark
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"zmPopupMenuCell";
    PopupMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PopupMenuCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = _textColor;
    cell.textLabel.font = [UIFont systemFontOfSize:_fontSize];
    cell.textLabel.text = [NSString stringWithFormat:@"PopupMenu_%ld",indexPath.row];
    cell.imageView.image = nil;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"indexPath= %ld",indexPath.row);
}



#pragma mark ======================"  setter getter UI  "==============================
- (UIView *)maskView {
    if (_maskView==nil) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PPWIDTH, PPHEIGHT)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        _maskView.alpha = 0;
    }return _maskView;
}
- (UILabel *)titleLab {
    if (_titleLab==nil) {
        _titleLab = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLab.font = PPFont(16);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }return _titleLab;
}
- (UITableView *)ttableView
{
    if (!_ttableView) {
        _ttableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _ttableView.backgroundColor = [UIColor clearColor];
        _ttableView.tableFooterView = [UIView new];
        _ttableView.delegate = self;
        _ttableView.dataSource = self;
        //_ttableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _ttableView;
}

#pragma mark ======================"  setter getter @property "==============================

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
}
- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    [self.ttableView reloadData];
}
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [self.ttableView reloadData];
}

- (void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
}
- (void)setItemHeight:(CGFloat)itemHeight{
    _itemHeight = itemHeight;
    self.ttableView.rowHeight = itemHeight;
    [self.ttableView reloadData];
}


- (void)setCornersOfView {
    
    CGSize radii = CGSizeMake(5,5);  //每个角的半径
    //不同的角度
    //UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    //用一个圆角矩形 初始化路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:radii];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor  = [UIColor magentaColor].CGColor;
    shapeLayer.fillColor    = [UIColor yellowColor].CGColor;
    shapeLayer.lineWidth    = 1;
    shapeLayer.lineJoin     = kCALineJoinRound;
    shapeLayer.lineCap      = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}
- (void)setIsShowShadow:(BOOL)isShowShadow
{
    _isShowShadow = isShowShadow;
    self.layer.shadowOpacity = isShowShadow ? 0.5 : 0;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = isShowShadow ? 2.0 : 0;
}


@end
