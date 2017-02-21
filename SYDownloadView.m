/**************************************************************************
 *
 *  Created by 舒少勇 on 2017/2/20.
 *    Copyright © 2017年 浙江踏潮网络科技有限公司. All rights reserved.
 *
 * 项目名称：浙江踏潮-汇道-搏击项目
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/
#import "SYDownloadView.h"

#define SYDownloadViewMargin self.bounds.size.width*0.19

static  NSString * const verticalAnimationKey = @"verticalAnimationKey";
static  NSString * const arrowAnimationKey = @"arrowAnimationKey";
static  NSString * const pathKey = @"path";
static  NSString * const arrowEndFinishedAnimationKey = @"arrowEndFinishedAnimationKey";


@interface SYDownloadView()<CAAnimationDelegate>

/**底部的背景圆*/
@property(nonatomic,strong)CAShapeLayer *bgCircleLayer;

/**进度圆*/
@property(nonatomic,strong)CAShapeLayer *progressLayer;

/**箭头*/
@property(nonatomic,strong)CAShapeLayer *arrowLayer;

/**竖线*/
@property(nonatomic,strong)CAShapeLayer *verticalLayer;

/**进度值显示的label*/
@property(nonatomic,strong)UILabel *progressLabel;

/**是否显示进度值*/
@property(nonatomic,assign,getter=isHiddenProgressL)BOOL hiddenProgressL;

@end

@implementation SYDownloadView

#pragma mark init- method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialze];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialze];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialze];
    }
    return self;
}

- (void)initialze
{
    self.hiddenProgressL = YES;
    self.lineWidth = 4;
    self.bgCircleLayer.lineWidth = self.lineWidth;
    CGFloat exLineW = self.lineWidth>1?self.lineWidth-1:self.lineWidth;;
    self.arrowLayer.lineWidth = exLineW;
    self.verticalLayer.lineWidth = exLineW;
}

#pragma mark lazy
- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        CGFloat height = self.bounds.size.height;
        CGFloat labelH = 20;
        _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (height-labelH)*0.5, self.bounds.size.width, labelH)];
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_progressLabel];
    }
    return _progressLabel;
}

- (CAShapeLayer *)bgCircleLayer
{
    if (!_bgCircleLayer) {
        _bgCircleLayer = [self pureCommonLayer];
        _bgCircleLayer.strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor;
        _bgCircleLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        [self.layer addSublayer:_bgCircleLayer];
    }
    return _bgCircleLayer;
}

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        _progressLayer = [self pureCommonLayer];
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        _progressLayer.strokeEnd = 0.f;
        _progressLayer.strokeStart = 0.f;
        [self.layer addSublayer:_progressLayer];
    }
    return _progressLayer;
}

- (CAShapeLayer *)arrowLayer
{
    if (!_arrowLayer) {
        _arrowLayer = [self pureCommonLayer];
        _arrowLayer.strokeColor = [UIColor whiteColor].CGColor;
        _arrowLayer.path = [self arrowPathWithMargin:SYDownloadViewMargin].CGPath;
        [self.layer addSublayer:_arrowLayer];
    }
    return _arrowLayer;
}

/**箭头一开始的路径*/
- (UIBezierPath*)arrowPathWithMargin:(CGFloat)margin
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat startX = (self.bounds.size.width*0.5)-2*margin;
    CGFloat startY = height - 3*margin;
    [path moveToPoint:CGPointMake(startX, startY)];
    CGFloat startx2 = (self.bounds.size.width*0.5);
    CGFloat starty2 = height - margin;
    [path addLineToPoint:CGPointMake(startx2, starty2)];
    [path addLineToPoint:CGPointMake((self.bounds.size.width*0.5)+2*margin, startY)];
    return  path;
}

/**箭头动画开始的路径*/
- (UIBezierPath*)arrowStartPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat startX = (self.bounds.size.width*0.5)-2*SYDownloadViewMargin;
    CGFloat startY = height - 3*SYDownloadViewMargin;
    [path moveToPoint:CGPointMake(startX, startY)];
    CGFloat startx2 = (self.bounds.size.width*0.5);
    CGFloat starty2 = height - SYDownloadViewMargin;
    [path addLineToPoint:CGPointMake(startx2, starty2)];
    [path addLineToPoint:CGPointMake((self.bounds.size.width*0.5)+2*SYDownloadViewMargin, startY)];
    return  path;
}

/**箭头动画结束的路径*/
- (UIBezierPath*)arrowEndPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat startX = (self.bounds.size.width*0.5)-2*SYDownloadViewMargin;
    CGFloat startY = height - 3*SYDownloadViewMargin;
    [path moveToPoint:CGPointMake(startX, startY)];
    CGFloat startx2 = (self.bounds.size.width*0.5);
    CGFloat starty2 = startY;
    [path addLineToPoint:CGPointMake(startx2, starty2)];
    [path addLineToPoint:CGPointMake((self.bounds.size.width*0.5)+2*SYDownloadViewMargin, startY)];
    return  path;
}

/**箭头动画恢复到原来的样子路径*/
- (UIBezierPath*)arrowStartFinishedPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat startX = (self.bounds.size.width*0.5)-2*SYDownloadViewMargin;
    CGFloat startY = height*0.5-SYDownloadViewMargin*0.5;
    [path moveToPoint:CGPointMake(startX+5, startY+5)];
    CGFloat startx2 = (self.bounds.size.width*0.5);
    CGFloat starty2 = height - SYDownloadViewMargin-SYDownloadViewMargin*0.5;
    [path addLineToPoint:CGPointMake(startx2, starty2)];
    [path addLineToPoint:CGPointMake((self.bounds.size.width*0.5)+2*SYDownloadViewMargin, startY)];
    return  path;
}

/**竖线路径*/
- (CAShapeLayer *)verticalLayer
{
    if (!_verticalLayer) {
        _verticalLayer = [self pureCommonLayer];
        _verticalLayer.strokeColor = [UIColor whiteColor].CGColor;
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat height = self.bounds.size.height;
        CGFloat startX = (self.bounds.size.width*0.5);
        CGFloat startY = SYDownloadViewMargin;
        [path moveToPoint:CGPointMake(startX, startY)];
        CGFloat starty2 = height - SYDownloadViewMargin;
        [path addLineToPoint:CGPointMake(startX, starty2)];
        _verticalLayer.path = path.CGPath;
        [self.layer addSublayer:_verticalLayer];
    }
    return _verticalLayer;
}
/**竖线动画结束路径*/
- (UIBezierPath*)verticalEndPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat startX = (self.bounds.size.width*0.5);
    CGFloat starty2 = SYDownloadViewMargin;
    [path moveToPoint:CGPointMake(startX, starty2)];
    [path addLineToPoint:CGPointMake(startX, starty2)];
    return  path;
}

/**竖线动画开始路径*/
- (UIBezierPath*)verticalLayerStartPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = self.bounds.size.height;
    CGFloat startX = (self.bounds.size.width*0.5);
    CGFloat startY = SYDownloadViewMargin;
    CGFloat starty2 = height - SYDownloadViewMargin;
    [path moveToPoint:CGPointMake(startX, startY)];
    [path addLineToPoint:CGPointMake(startX, starty2)];
    return path;
}

/**创建路径公用方法*/
- (CAShapeLayer*)pureCommonLayer
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = self.lineWidth;
    layer.lineCap = kCALineCapRound;
    layer.frame = self.bounds;
    layer.fillColor = [UIColor clearColor].CGColor;
    return layer;
}

#pragma mark animation
/**竖线动画*/
- (CAAnimationGroup*)verticalAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:pathKey];
    animation.values = @[ (__bridge id)[self verticalLayerStartPath].CGPath, (__bridge id)[self verticalEndPath].CGPath];
    animation.keyTimes = @[@0,@.15];
    animation.beginTime= 0.0f;
    
    CASpringAnimation *positionAnimation = [CASpringAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.toValue = @(SYDownloadViewMargin+SYDownloadViewMargin*0.61);
    positionAnimation.initialVelocity = 0;
    positionAnimation.mass = 1;
    positionAnimation.damping = 10;
    positionAnimation.beginTime = 0.5f;
    positionAnimation.removedOnCompletion = NO;
    positionAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation,positionAnimation];
    animationGroup.duration = 1.5;
    animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animationGroup;
}

/**竖线恢复到原来的样子的动画*/
- (CAAnimationGroup*)verticalFinishedAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:pathKey];
    animation.values = @[ (__bridge id)[self verticalEndPath].CGPath, (__bridge id)[self verticalLayerStartPath].CGPath];
    animation.keyTimes = @[@0,@.15];
    animation.beginTime= 0.0f;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation];
    animationGroup.duration = 1.5;
    animationGroup.repeatCount = 1;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return animationGroup;
}

/**箭头动画*/
- (CAAnimationGroup*)arrowAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:pathKey];
    animation.values = @[ (__bridge id)[self arrowStartPath].CGPath, (__bridge id)[self arrowEndPath].CGPath];
    animation.keyTimes = @[@0,@1.45];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.toValue = @0.f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation,opacity];
    group.duration = 1.5f;
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}

/**箭头恢复到原来的样子动画*/
- (CAAnimationGroup*)arrowstartFinishedAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:pathKey];
    animation.values = @[ (__bridge id)[self arrowStartFinishedPath].CGPath];
    animation.keyTimes = @[@0,@1.45];
    animation.beginTime= 0.0f;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.toValue = @1.f;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation,opacity];
    group.duration = 1.5f;
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}

/**用手指抬起执行动画*/
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    //开始动画
    [self.verticalLayer addAnimation:[self verticalAnimation] forKey:verticalAnimationKey];
    [self.arrowLayer addAnimation:[self arrowAnimation] forKey:arrowAnimationKey];
}

/**设置低圈颜色*/
- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.bgCircleLayer.strokeColor = bgColor.CGColor;
}

/**设置进度条颜色*/
- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    self.progressLayer.strokeColor = progressColor.CGColor;
    self.arrowLayer.strokeColor = progressColor.CGColor;
    self.verticalLayer.strokeColor = progressColor.CGColor;
}

/**进度条值颜色*/
- (void)setProgressValueColor:(UIColor *)progressValueColor
{
    _progressValueColor = progressValueColor;
    self.progressLabel.textColor = progressValueColor;
}

/**设置线宽*/
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    self.bgCircleLayer.lineWidth = lineWidth;
    CGFloat exLineW = lineWidth>1?lineWidth-1:lineWidth;;
    self.arrowLayer.lineWidth = exLineW;
    self.verticalLayer.lineWidth = exLineW;
}

/**设置进度值*/
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.progressLayer.strokeEnd = progress;
    if (!self.isHiddenProgressL) {
       self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",self.progress*100];
    }
    if (progress>=1.0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.progressLabel.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self.progressLabel removeFromSuperview];
            self.progressLabel = nil;
            [self.verticalLayer removeAllAnimations];
            [self.verticalLayer removeFromSuperlayer];
            self.verticalLayer = nil;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.arrowLayer addAnimation:[self arrowstartFinishedAnimation] forKey:arrowEndFinishedAnimationKey];
            });
        }];
    }
}

#pragma mark CAAnimationDelegate
/**监听动画结束*/
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([self.arrowLayer animationForKey:arrowEndFinishedAnimationKey] == anim) {
        [self.progressLabel removeFromSuperview];
    }else if ([self.arrowLayer animationForKey:arrowAnimationKey] == anim){
        self.hiddenProgressL = NO;
    }
}

@end
