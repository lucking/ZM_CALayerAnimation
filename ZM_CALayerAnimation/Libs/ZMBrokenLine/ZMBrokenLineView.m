//
//  ZMBrokenLineView.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2018/3/27.
//  Copyright © 2018年 ZM. All rights reserved.
//

#import "ZMBrokenLineView.h"
#import "ZMBrokenLineHeader.h"
#import "UIView+ZMBrokenLine.h"

@interface ZMBrokenLineView ()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *xTitleLabel;
@property(nonatomic, strong) UILabel *yTitleLabel;

@property(nonatomic, strong) CAShapeLayer * linePath;
@property(nonatomic, assign) CGFloat avgHeight;
@property(nonatomic, assign) NSInteger maxValue;
@property(nonatomic, assign) NSInteger count;
@end


@implementation ZMBrokenLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _linePath= [CAShapeLayer layer];
        _linePath.lineCap=  kCALineCapRound;
        _linePath.lineJoin= kCALineJoinBevel;
        _linePath.lineWidth=2;
        _linePath.fillColor=    [UIColor clearColor].CGColor;
        [self.layer addSublayer:_linePath];
        _maxValue=1;
    }
    return self;
}
-(NSInteger)maxValue {
    for (int i=0; i<self.count; i++) {
        NSInteger value=[_dataSource chart:self valueAtIndex:i];
        _maxValue=  value>_maxValue?value:_maxValue;
    }
    return _maxValue;
}

-(NSInteger)count{
    return [_dataSource numberForChart:self];
}
-(CGFloat)avgHeight
{
    CGFloat height= self.frame.size.height;
    _avgHeight=(height-4*zmMargin)/self.maxValue;
    return _avgHeight;
}
-(void)drawRect:(CGRect)rect
{
    [self setupCoordinate];
    [self setupTitle];
    [self drawOriginAndMaxPoint];
    UIBezierPath *path=[UIBezierPath bezierPath];
    for (int i=0; i<self.count; i++) {
        CGFloat value=[_dataSource chart:self valueAtIndex:i];
        CGPoint point=[self pointWithValue:value index:i];
        if (i==0) {
            [path moveToPoint:point];
        }else{
            [path addLineToPoint:point];
        }
    }
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle= kCGLineJoinRound;
    //path.lineWidth=1;
    [[UIColor redColor]setStroke];
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue= [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=   [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses= NO;
    _linePath.path= path.CGPath;
    _linePath.strokeEnd = 1.0;
    _linePath.strokeColor= [UIColor redColor].CGColor;
    [_linePath addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    
    for (int i=0; i<self.count; i++) {
        
        CGFloat value=  [_dataSource chart:self valueAtIndex:i];
        CGPoint point=  [self pointWithValue:value index:i];
        UIBezierPath *drawPoint=    [UIBezierPath bezierPath];
        [drawPoint addArcWithCenter:point radius:zmradius startAngle:M_PI*0 endAngle:M_PI*2 clockwise:YES];
        CAShapeLayer *layer=    [[CAShapeLayer alloc]init];
        layer.path= drawPoint.CGPath;
        _linePath.strokeEnd=    1;
        
        [self.layer addSublayer:layer];
        if (_dataSource&&[_dataSource respondsToSelector:@selector(showDataAtPointForChart:)]&&[_dataSource showDataAtPointForChart:self]) {
            NSString *valueString= [NSString stringWithFormat:@"%ld",(long)value];
            CGRect frame= [valueString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:zmFFont(14.f)} context:nil];
            //pointForValueString
            CGPoint valuePoint= CGPointMake(point.x-frame.size.width/2, point.y+zmMargin/3);
            if (valuePoint.y+ frame.size.height>self.height-1.5*zmMargin) {
                valuePoint.y= point.y-1.5*zmMargin;
            }
            [valueString drawAtPoint:valuePoint withAttributes:@{NSFontAttributeName: zmFFont(14.f)}];
        }
        if (_dataSource&&[_dataSource respondsToSelector:@selector(chart:titleForXLabelAtIndex:)]) {
            NSString *titleForXLabel=[_dataSource chart:self titleForXLabelAtIndex:i];
            if (titleForXLabel) {
                [self drawXLabel:titleForXLabel index:i];
            }
        }
    }
    
}
-(void)drawXLabel:(NSString *)text index:(NSInteger)index
{//
    NSDictionary *font=@{NSFontAttributeName: [UIFont systemFontOfSize:12.f]};
    CGPoint point=[self pointWithValue:0 index:index];
    CGSize size=[text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:font context:nil].size;
    point.x-=size.width/2;
    point.y+=3;
    [text drawAtPoint:point withAttributes:font];
}
-(void)drawOriginAndMaxPoint
{
    NSDictionary *font=@{NSFontAttributeName: [UIFont systemFontOfSize:12.f]};
    
    NSString *origin=@"0";
    [origin drawAtPoint:CGPointMake(0.9*zmMargin, self.frame.size.height-2*zmMargin) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11.f]}];
    
    NSString *max=[NSString stringWithFormat:@"%ld",(long)self.maxValue];
    CGRect tmpFrame= [max boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:
                      NSStringDrawingUsesLineFragmentOrigin attributes:font context:nil];
    [max drawAtPoint:CGPointMake(1.5*zmMargin-tmpFrame.size.width-1, [self pointWithValue:_maxValue index:0].y-5) withAttributes:font];
}
- (void)setTitle:(NSString *)title {
    _title= title;
    self.titleLabel.text= title;
}

- (void)setXTitle:(NSString *)xTitle {
    _xTitle= xTitle;
    self.xTitleLabel.text= xTitle;
    
    //    CGRect frame= [xTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.f]} context:nil];
    //    [xTitle drawAtPoint:CGPointMake(self.frame.size.width-zmMargin-frame.size.width,self.frame.size.height-2*zmMargin-frame.size.height) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.f]}];
    //    self.titleLabel.frame = CGRectMake(0, 0, self.width, 20);
    //    self.xTitleLabel.frame = frame;
}

- (void)setYTitle:(NSString *)yTitle {
    _yTitle= yTitle;
    //    [yTitle drawAtPoint:CGPointMake(1.5*zmMargin,0.5*zmMargin) withAttributes:nil];
}

-(void)setupTitle
{
    //    if (_dataSource&&[_dataSource respondsToSelector:@selector(titleForChart:)]) {
    //        self.titleLabel.text= [_dataSource titleForChart:self];
    //    }
    if (_dataSource&&[_dataSource respondsToSelector:@selector(titleForYAtChart:)]) {
        NSString *yTitle=[_dataSource titleForYAtChart:self];
        [yTitle drawAtPoint:CGPointMake(1.5*zmMargin,0.5*zmMargin) withAttributes:nil];
    }
    if (_dataSource&&[_dataSource respondsToSelector:@selector(titleForXAtChart:)]) {
        NSString *xTitle=[_dataSource titleForXAtChart:self];
        CGRect frame=[xTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.f]} context:nil];
        [xTitle drawAtPoint:CGPointMake(self.frame.size.width-zmMargin-frame.size.width,self.frame.size.height-2*zmMargin-frame.size.height) withAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.f]}];
    }    
}
// 安装坐标系
-(void)setupCoordinate
{
    //[[UIColor orangeColor] set]; （0, y）、（0,0）、（x,0）
    UIBezierPath *coordinate= [UIBezierPath bezierPath];
    [coordinate moveToPoint:CGPointMake(1.5*zmMargin, 1.5*zmMargin)];
    [coordinate addLineToPoint:CGPointMake(1.5*zmMargin, self.height-1.5*zmMargin)];
    [coordinate addLineToPoint:CGPointMake(self.width-zmMargin, self.height-1.5*zmMargin)];
    [coordinate stroke];
    //Y箭头
    [[UIColor cyanColor] setStroke];
    UIBezierPath *arrowsForY=[UIBezierPath bezierPath];
    [arrowsForY moveToPoint:CGPointMake(zmMargin, zmMargin*2)];
    [arrowsForY addLineToPoint:CGPointMake(1.5*zmMargin, 1.5*zmMargin)];
    [arrowsForY addLineToPoint:CGPointMake(zmMargin*2, zmMargin*2)];
    [arrowsForY stroke];
    //X箭头
    [[UIColor magentaColor] setStroke];
    UIBezierPath *arrowsForX = [UIBezierPath bezierPath];
    [arrowsForX moveToPoint:CGPointMake(self.width-(zmMargin*1.5), self.height-(zmMargin*2))];
    [arrowsForX addLineToPoint:CGPointMake(self.width-zmMargin, self.height-1.5*zmMargin)];
    [arrowsForX addLineToPoint:CGPointMake(self.width-(zmMargin*1.5), self.height-(zmMargin*1))];
    [arrowsForX stroke];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    //    NSLog(@"_count= %ld", _count);
    NSLog(@"self.count= %ld", self.count);
    
    for (NSInteger i=0; i< self.count; i++) {
        NSInteger value=[_dataSource chart:self valueAtIndex:i];
        CGPoint point=[self pointWithValue:value index:i];
        if (CGRectContainsPoint(CGRectMake(point.x-zmradius, point.y-zmradius, zmradius*2, zmradius*2), [touch locationInView:self])) {
            if (_delegate&&[_delegate respondsToSelector:@selector(chart:didClickPointAtIndex:)]) {
                [_delegate chart:self didClickPointAtIndex:i];
            }
        }
    }
}
-(UILabel *)titleLabel {
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:14.f];
        [self addSubview:_titleLabel];
        _titleLabel.translatesAutoresizingMaskIntoConstraints=NO;
        _titleLabel.textAlignment= NSTextAlignmentCenter;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    } return _titleLabel;
}
-(UILabel *)xTitleLabel {
    if (_xTitleLabel==nil) {
        _xTitleLabel=[[UILabel alloc]init];
        _xTitleLabel.font=[UIFont systemFontOfSize:12.f];
        _xTitleLabel.textAlignment= NSTextAlignmentLeft;
        [self addSubview:_xTitleLabel];
    } return _xTitleLabel;
}
-(UILabel *)yTitleLabel {
    if (_yTitleLabel==nil) {
        _yTitleLabel=[[UILabel alloc]init];
        _yTitleLabel.font=[UIFont systemFontOfSize:12.f];
        _yTitleLabel.textAlignment= NSTextAlignmentLeft;
        [self addSubview:_yTitleLabel];
    } return _yTitleLabel;
}

-(CGPoint)pointWithValue:(NSInteger)value index:(NSInteger)index
{
    CGFloat height= self.frame.size.height;
    CGFloat width=  self.frame.size.width;
    return  CGPointMake(2.5*zmMargin+(width-2*zmMargin)/self.count*index, height-value*self.avgHeight-1.5*zmMargin);
}
-(void)reload
{
    [self layoutIfNeeded];
}

@end
