//
//  ZMPopupMenuView.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "ZMPopupMenuView.h"
#import "UIView+PPFrame.h"
#import "PopupMenuHeader.h"
#import "PopupMenuCell.h"

@interface ZMPopupMenuView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView    *maskView;
@property (nonatomic, assign) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UITableView *ttableView;
//凸起三角
@property (nonatomic, strong) UIBezierPath *linePath;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) UIBezierPath *linePath2;
@property (nonatomic, strong) CAShapeLayer *lineLayer2;
@property (nonatomic) CGPoint relyPoint;
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

    self.alpha = 1;
    self.backgroundColor = [UIColor clearColor];
    self.humpType = TopHumpMode;
    self.dismissOnTouchOutside = YES;
    self.isShowShadow = YES;
    self.lineColor = [UIColor magentaColor];
    self.fillColor = [UIColor whiteColor];
    [self setCornersOfView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(touchOutSide)];
    [self.maskView addGestureRecognizer: tap];
    [self addSubview:self.ttableView];
}
//创建UI
- (void)createUI {
    [PPKeyWindow addSubview:self.maskView];
    [PPKeyWindow addSubview:self];
}
//单击maskView
- (void)touchOutSide {
    if (_dismissOnTouchOutside) {
        [self dismiss];
    }
}


- (ZMPopupMenuView *)showRelyOnView:(UIView *)view
                             titles:(NSArray *)titles
                              icons:(NSArray *)icons
                          menuWidth:(CGFloat)itemWidth
                           delegate:(id<ZMPopupMenuViewDelegate>)delegate
{
    
    CGRect absoluteRect = [view convertRect:view.bounds toView:PPKeyWindow];
    CGPoint relyPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y + absoluteRect.size.height);
    NSLog(@"relyPointX= %f",relyPoint.x);
    NSLog(@"relyPointY= %f \n",relyPoint.y);
    
    ZMPopupMenuView *popupMenuView = [[ZMPopupMenuView alloc]initWithFrame:CGRectMake(150, 200, 150,260)];
    popupMenuView.delegate   = delegate;
    popupMenuView.titleArray = titles;
    popupMenuView.imageArray = icons;
    popupMenuView.relyPoint  = relyPoint;
    [popupMenuView show];
    
    return popupMenuView;
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
//        [self removeFromSuperview];
//        [_maskView removeFromSuperview];
    }];
}
//置空
- (void)removeAndSetNil {
//    [_linePath removeAllPoints];
//    [_linePath2 removeAllPoints];
//    [_lineLayer removeFromSuperlayer];
//    [_lineLayer2 removeFromSuperlayer];
//    _linePath=nil;
//    _linePath=nil;
//    _lineLayer= nil;
//    _lineLayer2= nil;
    [_maskView removeFromSuperview];
    [self removeAllSubview];
    [self removeFromSuperview];
}

#pragma mark ======================"  tableViewDelegate && dataSource  "==============================
#pragma mark
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
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
        cell.cellWidth= self.width;
        cell.cellHeight= 40;
    }
    if (self.imageArray!=nil && self.imageArray.count>0) {
        cell.imgView.image= PPIMG(self.imageArray[indexPath.row]);
    }
    cell.titleLab.text = self.titleArray[indexPath.row];
  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(popupMenuView:didSelectItemAtIndex:)]) {
        [self.delegate popupMenuView:self didSelectItemAtIndex:indexPath.row];
    }
    [self dismiss];
}


#pragma mark ======================"  setter getter UI  "==============================
- (UIView *)maskView {
    if (_maskView==nil) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PPWIDTH, PPHEIGHT)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        _maskView.alpha = 0;
    }return _maskView;
}
- (UITableView *)ttableView {
    if (!_ttableView) {
        _ttableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
        _ttableView.backgroundColor = [UIColor clearColor];
        _ttableView.tableHeaderView = [UIView new];
        _ttableView.tableFooterView = [UIView new];
        _ttableView.delegate = self;
        _ttableView.dataSource = self;
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
//获取数据
-(void)setTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray {
    _titleArray= titleArray;
    _imageArray= imageArray;
    [self.ttableView reloadData];
}
- (void)setHumpType:(HumpType)humpType{
    _humpType= humpType;
    [self drawLineHump];
}


// 绘图
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];  NSLog(@"--> drawRect：绘制UI_渲染绘图 \n ");
    //[self drawLineHump];
}

// 设置凸起：（画线）
-(void)drawLineHump {
    
    [_linePath removeAllPoints];
    [_linePath2 removeAllPoints];
    [_lineLayer removeFromSuperlayer];
    [_lineLayer2 removeFromSuperlayer];
    //默认top凸起
    CGPoint point1 = CGPointMake(self.width/2-10, 0);
    CGPoint point3 = CGPointMake(self.width/2+10, 0);
    CGPoint point2 = CGPointMake(self.width/2, -10);
    CGPoint pointA= CGPointMake(point1.x+1, point1.y);
    CGPoint pointB= CGPointMake(point3.x-1, point3.y);
    
    //top凸起
    if (_humpType==TopHumpMode) {
        point1 = CGPointMake(self.width/2-10, 0);
        point3 = CGPointMake(self.width/2+10, 0);
        point2 = CGPointMake(self.width/2, -10);
        pointA= CGPointMake(point1.x+1, point1.y);
        pointB= CGPointMake(point3.x-1, point3.y);
    }//bottom凸起
    else if (_humpType==BottomHumpMode){
        point1 = CGPointMake(self.width/2-10, self.height);
        point3 = CGPointMake(self.width/2+10, self.height);
        point2 = CGPointMake(self.width/2, self.height+10);
        pointA= CGPointMake(point1.x+1, point1.y);
        pointB= CGPointMake(point3.x-1, point3.y);
    }//left凸起
    else if (_humpType==LeftHumpMode){
        point1 = CGPointMake(0, self.height/2-10);
        point3 = CGPointMake(0, self.height/2+10);
        point2 = CGPointMake(-10, self.height/2);
        pointA= CGPointMake(point1.x, point1.y+1);
        pointB= CGPointMake(point3.x, point3.y-1);
    }//right凸起
    else if (_humpType==RightHumpMode){
        point1 = CGPointMake(self.width, self.height/2-10);
        point3 = CGPointMake(self.width, self.height/2+10);
        point2 = CGPointMake(self.width+10, self.height/2);
        pointA= CGPointMake(point1.x, point1.y+1);
        pointB= CGPointMake(point3.x, point3.y-1);
    }
    
    //三角凸起
    //NSLog(@"---> self.centerX = %f\n ",self.centerX);
    _linePath = [UIBezierPath bezierPath];
    [_linePath moveToPoint:point1];      // 起点
    [_linePath addLineToPoint:point2];   // 第2个点
    [_linePath addLineToPoint:point3];   // 第3个点
    //（使用图层填充）
    _lineLayer = [CAShapeLayer layer];
    _lineLayer.path = _linePath.CGPath;
    _lineLayer.lineWidth    = 1;
    _lineLayer.strokeColor  = self.lineColor.CGColor;
    _lineLayer.fillColor    = self.fillColor.CGColor;
    [self.layer addSublayer:_lineLayer];
    //覆盖三角空心处
    _linePath2 = [UIBezierPath bezierPath];
    [_linePath2 moveToPoint:pointA];     // 起点
    [_linePath2 addLineToPoint:pointB];  // 第2个点
    _lineLayer2 = [CAShapeLayer layer];
    _lineLayer2.path = _linePath2.CGPath;
    _lineLayer2.lineWidth   = 1;
    _lineLayer2.strokeColor = self.fillColor.CGColor;
    _lineLayer2.fillColor   = self.fillColor.CGColor;
    [self.layer addSublayer:_lineLayer2];
}
//设置圆角
- (void)setCornersOfView {
    //用一个圆角矩形 初始化路径
    CGSize radii = CGSizeMake(5,5);  //每个角的半径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:radii];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor  = self.lineColor.CGColor;
    shapeLayer.fillColor    = self.fillColor.CGColor;
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
