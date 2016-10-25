//
//  HMRGBSelectView.m
//  RGBDemo2
//
//  Created by zhoucan on 2016/10/25.
//  Copyright © 2016年 verfing. All rights reserved.
//

#import "HMRGBSelectView.h"



/**
 背景图片
 */

@interface HMRGBSelectView()

@property(nonatomic,strong)UIImageView *sliderImageView;
@property (weak, nonatomic) IBOutlet UIImageView *slider;

@end

@implementation HMRGBSelectView
{
    CGRect _originalSize;        //初始大小
    CGPoint _startPoint;             //初始化起始点
    CGFloat _currentAngle;          //当前角度
    
    int _mark;                               //刻度
    
    CGFloat _minAngle;               //最小角度
    CGFloat _maxAngle;               //最大角度
    
    int _minMark;                            //最小刻度数值
    int _maxMark;                            //最大刻度数值
    
    CGFloat _anglePerMark;           //每个刻度见的角度
    
    CGFloat _maxRadius;                 //根据大小半径设置可以响应手势的环状范围
    CGFloat _minRadius;
    
    
    
}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        [self addSubview:self.pointView];
    }
    return self;
}

//设置角度限制  和 刻度的最大和最小值


//设置初始角度位置
-(void)getTheStartAngle:(CGFloat)angle{
    
    [self setRotationAngle:angle ForView:self.slider];
    
}
//设置可以响应滑动手势的环状范围
-(void)setAreaForPanWithMaxRadius:(CGFloat)max MinRadius:(CGFloat)min{
    _maxRadius = max;
    _minRadius = min;
}
-(void)setRotationAngle:(CGFloat)angle ForView:(UIView *)view{
    CGFloat radAngle = [self getRadWithAngle:angle];
    CGAffineTransform angleTransform = CGAffineTransformMakeRotation(radAngle);
//    NSString * rangerA = [NSString stringWithFormat:@"%f",radAngle];
//    _pointView.text = rangerA;
    view.transform = angleTransform;
    
    
    CGFloat r =  self.frame.size.height/2.0 + 3;
    
    self.selectPoint =  CGPointMake(r+r*sin(radAngle),r-r*cos(radAngle));
    
    if ([_delegate respondsToSelector:@selector(getRGBPoint:)]) {
        [_delegate getRGBPoint:self.selectPoint];
    }
    
//    _pointView.transform = angleTransform;
}
-(CGFloat)getRadWithAngle:(CGFloat)angle{
    return angle*M_PI/180;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.superview];
    
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
//    view.backgroundColor = [UIColor greenColor];
//    view.center = CGPointMake(_slider.center.x, 0);
//    [ addSubview:view];
    

    
    _startPoint = point;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint movePoint = [touch locationInView:self];
    
    
    
    CGFloat angle = [self getDegreeWithOldPoint:_startPoint NewPoint:movePoint CenterPoint:_slider.center];
    
    
    _startPoint = movePoint;
    if ([self panArea:movePoint]) {//判断可响应的环状位置
            [self setCyclingAngleWith:angle+_currentAngle];
        
        [self setRotationAngle:_currentAngle ForView:_slider];
        
    }
}


-(void)sendMarkNumber:(int)mark{
    if (_mark!=mark) {
        _mark = mark;
    }
}
-(void)sendMarkNumberAtTouchEnd:(int)mark{
    _mark = mark;
}
//根据角度返回刻度值
-(int)returnNumberWithAngle:(CGFloat)angle{
    if (angle>=_minAngle&&angle<_minAngle+_anglePerMark/2) {
        return _minMark;
    }
    else if (angle>=_minAngle+_anglePerMark/2&&angle<_maxAngle-_anglePerMark/2){
        return (angle-_anglePerMark/2)/_anglePerMark+1;
    }
    else{
        return _maxMark;
    }
}

//转动时角度限制在min和max之间
-(void)setAngleWith:(CGFloat)angle{
    _currentAngle = angle;
    if (_currentAngle<=_minAngle) {
        _currentAngle = _minAngle;
    }else if (_currentAngle>=_maxAngle){
        _currentAngle = _maxAngle;
    }
}
//#warning 不完善相关  以后可继续添加 此处为算法不完善且关联较多
//转动时角度限制在min和max之间且可循环  仅仅360整数倍可用 以后添加的话需要添加指定算法
-(void)setCyclingAngleWith:(CGFloat)angle{
    _currentAngle = angle;
    if (_currentAngle>_maxAngle) {
        _currentAngle -= _maxAngle;
    }else if (_currentAngle<=_minAngle){
        _currentAngle +=_maxAngle;
    }
}
-(CGFloat)getDegreeWithOldPoint:(CGPoint)old NewPoint:(CGPoint)new CenterPoint:(CGPoint)center{
    CGFloat tanOld = (old.y-center.y)/(old.x-center.x);
    CGFloat tanNew = (new.y-center.y)/(new.x-center.x);
    
    CGFloat changAngleTan = (tanNew - tanOld)/(1+tanOld*tanNew);
    
    //斜率为零的判断
    if (isnan(changAngleTan)) {
        changAngleTan = 0;
    }
    CGFloat angle = atanf(changAngleTan)/M_PI*180;
    return angle;
}

//判断响应滑动控制的圆环状范围  根据图片中得圆环自行设定  不设置则默认为整个图片区域
- (BOOL)panArea:(CGPoint )pan
{
    // 获得当前位置的相对坐标
    CGPoint pNew = pan;
    
    // 控件中心点
    CGPoint pCen = self.superview.center;
    
    CGFloat len = sqrt((pNew.x - pCen.x)*(pNew.x - pCen.x) + (pNew.y - pCen.y)*(pNew.y - pCen.y));
    
    if (_maxRadius && _minRadius) {
        if (len > _maxRadius || len < _minRadius) {
            return NO;
        }
    }
    return YES;
}

//
//- (UIView *)pointView
//{
//    if (_pointView == nil) {
//        _pointView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
//        _pointView.center = CGPointMake(self.center.x, -20);
//        _pointView.backgroundColor =[UIColor clearColor];
//    }
//    
//    return _pointView;
//   
//    
//}
@end
