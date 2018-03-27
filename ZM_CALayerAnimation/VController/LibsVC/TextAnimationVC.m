//
//  TextAnimationVC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/18.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "TextAnimationVC.h"
#import "UIBezierPath+ZJText.h"
#import "UIView+ZMAdd.h"
#import "BaseHeader.h"

@interface TextAnimationVC ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *txtField;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSMutableDictionary *attrs;
@end

@implementation TextAnimationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"TextAnimationVC";
    [self.view addSubview:self.txtField];
    [self addBtnTitle:@"播放" frame:CGRectMake(260, 80, 60, 35) Tag:0];
    
    [self.view.layer addSublayer:self.shapeLayer];
    self.txtField.delegate = self;
    self.txtField.text = @"load...";
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self myBtnClick:nil];
}

- (void)myBtnClick:(UIButton *)Btn{
    
    if (_txtField.text.length > 0)
    {
        UIBezierPath *path = [UIBezierPath zjBezierPathWithText:_txtField.text attributes:self.attrs];
        self.shapeLayer.bounds = CGPathGetBoundingBox(path.CGPath);
        self.shapeLayer.path = path.CGPath;
        [self.shapeLayer removeAllAnimations];
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.5f * _txtField.text.length;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    }
}


- (UITextField *)txtField {
    if (!_txtField) {
        _txtField = [[UITextField alloc] init];
        _txtField.frame = CGRectMake(20, 80,200 , 35);
        _txtField.backgroundColor = [UIColor yellowColor];
        _txtField.clearButtonMode = UITextFieldViewModeWhileEditing; //清空模式
        [_txtField cornerRadius:5.f borderWidth:1.2f borderColor:Color_70AEE1];
    }
    return _txtField;
}

-(CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil){
        CGSize size = self.view.frame.size;
        CGFloat height = 250;
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = CGRectMake(0, (size.height - height)/2, size.width , height);
        _shapeLayer.geometryFlipped = YES;
        _shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;;
        _shapeLayer.lineWidth = 2.0f;
        _shapeLayer.lineJoin = kCALineJoinRound;
    }
    return _shapeLayer;
}

-(NSMutableDictionary *)attrs
{
    if (_attrs == nil){
        _attrs = [[NSMutableDictionary alloc] init];
        [_attrs setValue:[UIFont boldSystemFontOfSize:50] forKey:NSFontAttributeName];
    }
    return _attrs;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
