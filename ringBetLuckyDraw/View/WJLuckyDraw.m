//
//  WJLuckyDraw.m
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/13.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import "WJLuckyDraw.h"
#import "WJLuckyDrawDataModel.h"
#import "HBLuckyDrawButton.h"
#import "SIAlertView.h"
#include <math.h>
#import "UIImage+Extension.h"
#import "UIColor+Hex.h"

BOOL const isDebug = NO;

NSString * const kHBLuckyDrawAnimationKey = @"kHBLuckyDrawAnimationKey";

@interface WJLuckyDraw ()
@property (nonatomic, strong) UIButton    *startOrPause;///< 开始或停止
@property (nonatomic, strong) UIView      *fansContainer;///< 所有扇形容器
@property (nonatomic, strong) UIImageView *zhiZhen;///< 指针
@property (nonatomic, assign) double rotatedAngle; ///< 转过的角度
@end

@implementation WJLuckyDraw
#pragma mark -
#pragma mark life cycle
- (instancetype)initLuckyDrawWithCenterButtonImage:(NSString *)image selectedImage:(NSString *)selectedImage {
    if (self = [super init]) {
        
        _fansContainer = [UIView new];
//        _fansContainer.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_fansContainer];
        
        _zhiZhen = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zhizhen"]];
        [self addSubview:_zhiZhen];
        
        _startOrPause = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startOrPause setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [_startOrPause setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateDisabled];
        [_startOrPause setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:_startOrPause];
        [_startOrPause addTarget:self action:@selector(clickedStartOrPauseButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_fansContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
        
        [_startOrPause mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.388);
            make.height.equalTo(_startOrPause.mas_width);
        }];
        
        [_zhiZhen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_centerY);
            make.centerX.equalTo(self);
            make.height.equalTo(_startOrPause).multipliedBy(1.8 * 0.5);
            make.width.equalTo(_zhiZhen.mas_height).multipliedBy(0.2121);
        }];
    }
    return self;
}

#pragma mark -
#pragma mark event response
- (void)clickedStartOrPauseButton:(UIButton *)startOrPause {
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    
    double random = 0.0;
    if (isDebug) {
        random = arc4random() % 10 + (double)arc4random() / 0x100000000;
        anim.duration = 0.1;
    }
    else {
        random = arc4random() % 10 + 20 + (double)arc4random() / 0x100000000;
        anim.duration = 8;
    }
    anim.toValue = @(random * M_PI);
    _rotatedAngle = random * M_PI;
    
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    // 设置样式，开头和结尾比较慢,中间快
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [_fansContainer.layer addAnimation:anim forKey:kHBLuckyDrawAnimationKey];
    
    // 转动开始用户不可点击
    _startOrPause.enabled = NO;
}

#pragma mark -
#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if ([[_fansContainer.layer animationForKey:kHBLuckyDrawAnimationKey] isEqual:anim]) {
        WJLog(@"动画停止");
        
        // 转动结束用户可点击
        _startOrPause.enabled = YES;
        
        for (HBLuckyDrawButton *button in _fansContainer.subviews) {

            CGFloat rotatedAngleFact = fmod(_rotatedAngle, M_PI * 2);
            
            // 判断3/4圆位置在哪个按钮的startAngle和endAngle之间（参考点）
            CGFloat lineThreeFourths = M_PI_2 * 3;
            
            // 按钮起始和结束位置的相对角度，因为转过的角度如果超过了270，就无法判断到，所以要取模
            CGFloat buttonStartAngle = button.startAngle + rotatedAngleFact;
            CGFloat buttonEndAngle = button.endAngle + rotatedAngleFact;
            // 只有起始位置都超过一个圆周才取模，否则比如起始 350，结束 380的情况就无法判断到
            if (buttonStartAngle > M_PI * 2 && buttonEndAngle > M_PI * 2) {
                buttonStartAngle = fmod(buttonStartAngle, M_PI * 2);
                buttonEndAngle = fmod(buttonEndAngle, M_PI * 2);
            }
            WJLog(@"  %@**3/4圆位置：%f**转过：%f**取模当前起始位置：%f**取模当前结束位置：%f**当前起始位置：%f**当前结束位置：%f**本身起始位置：%f**本身结束位置：%f", button.luckyDrawDataModel.descriptionStr, Angle2Degree(lineThreeFourths), Angle2Degree(rotatedAngleFact), Angle2Degree(buttonStartAngle), Angle2Degree(buttonEndAngle), Angle2Degree(button.startAngle + rotatedAngleFact), Angle2Degree(button.endAngle + rotatedAngleFact), Angle2Degree(button.startAngle), Angle2Degree(button.endAngle));
            
            if (lineThreeFourths > buttonStartAngle && lineThreeFourths < buttonEndAngle) {
                WJLog(@"恭喜：%@", button.luckyDrawDataModel.descriptionStr);
                @WJWeakObj(self);
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:[NSString stringWithFormat:@"恭喜您获得%@", button.luckyDrawDataModel.descriptionStr]];
                [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {

                    // 通知代理
                    if ([selfWeak.deleagte respondsToSelector:@selector(luckyDraw:result:)]) {
                        [selfWeak.deleagte luckyDraw:selfWeak result:button.luckyDrawDataModel];
                    }
                    // 刷新界面
                    [_dataSource removeObject:button.luckyDrawDataModel];
                    [selfWeak refreshUIWithDataSource:_dataSource];
                }];
                alertView.titleColor = [UIColor redColor];
                alertView.messageColor = [UIColor orangeColor];
                alertView.buttonColor = [UIColor blueColor];
                alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                [alertView show];
                
                break;
            }
//            if (lineThreeFourths == buttonStartAngle || lineThreeFourths == buttonEndAngle) {
//                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:[NSString stringWithFormat:@"太牛了，转到边界了"]];
//                [alertView addButtonWithTitle:@"再来一次" type:SIAlertViewButtonTypeCancel handler:nil];
//                alertView.titleColor = [UIColor redColor];
//                alertView.messageColor = [UIColor orangeColor];
//                alertView.buttonColor = [UIColor blueColor];
//                alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
//                [alertView show];
//                
//                break;
//            }
//            if (lineThreeFourths < buttonStartAngle && lineThreeFourths > buttonEndAngle) {
//                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:[NSString stringWithFormat:@"穿越了"]];
//                [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
//                alertView.titleColor = [UIColor redColor];
//                alertView.messageColor = [UIColor orangeColor];
//                alertView.buttonColor = [UIColor blueColor];
//                alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
//                [alertView show];
//                
//                break;
//            }
        }
    }
}

#pragma mark -
#pragma mark getters and setters
- (void)setDataSource:(NSMutableArray *)dataSource {
    if (isDebug) {
        [dataSource removeObjectsInRange:NSMakeRange(2, 25)];
    }
    _dataSource = dataSource;
    
    [self refreshUIWithDataSource:dataSource];
}

#pragma mark -
#pragma mark private methods
- (void)refreshUIWithDataSource:(NSArray *)dataSource {
    // 先移除所有的按钮和图层
    [_fansContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_fansContainer.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    for (NSUInteger i = 0; i < dataSource.count; i++) {
        WJLuckyDrawDataModel *model = dataSource[i];
        
        HBLuckyDrawButton *btn = [HBLuckyDrawButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setBackgroundImage:[UIImage createImageWithColor:[UIColor redColor]] forState:UIControlStateSelected];
//        btn.backgroundColor = i % 2 != 0 ? WJColor(255, 244, 215, 0.9) : [UIColor whiteColor];
        btn.luckyDrawDataModel = model;
        [btn setTitleColor:[UIColor colorWithHexString:@"#a2591e"] forState:UIControlStateNormal];
        [btn setTitle:model.descriptionStr forState:UIControlStateNormal];
        [_fansContainer addSubview:btn];
    }
    [self setNeedsLayout];
}

#pragma mark -
#pragma mark layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat W = _fansContainer.width;
    CGFloat H = _fansContainer.height;
    
    // 绘制背景
    NSUInteger count = _fansContainer.subviews.count;
    
    CGFloat averageAngle = Degree2Angle(360.0 / count);///< 平均一格占的角度
    CGFloat radius = W * 0.5;///< 半径
    CGPoint center = _startOrPause.center;///< 圆心
    CGFloat btnHeight = 2 * sin(averageAngle * 0.5) * radius;///< 按钮高度
    CGFloat btnWidth = cos(averageAngle * 0.5) * radius;///< 按钮宽度
    
    // 解决count过少按钮宽度过小导致文字过分靠内显示
    if (count >= 2 && count <= 4) {
        btnHeight *= 0.5;
        btnWidth = radius;
    }
    CGFloat startAngle = -atan(btnHeight * 0.5 / btnWidth);///< 背景起始角度
    
    for (NSUInteger i = 0; i < count; i++) {
        HBLuckyDrawButton *btn = _fansContainer.subviews[i];
        btn.size = CGSizeMake(btnWidth, btnHeight);
        btn.centerY = H * 0.5;
        btn.left = W * 0.5;
        
        // 设置锚点和位置
        btn.layer.anchorPoint = CGPointMake(0, 0.5);
        btn.layer.position = CGPointMake(W * 0.5, H * 0.5);
        
        // 设置旋转角度(绕着锚点进行旋转)
        CGFloat angle = averageAngle * i;
        btn.transform = CGAffineTransformMakeRotation(angle);
        
        // 按钮起始和结束角度
        CGFloat pathStartAngle = startAngle + i * averageAngle;
        CGFloat pathEndAngle   = pathStartAngle + averageAngle;
        
        // 算按钮对应的起始和结束角度
        btn.startAngle = pathStartAngle;
        btn.endAngle = pathEndAngle;
        
        // bezierPath形成闭合的扇形路径
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:pathStartAngle endAngle:pathEndAngle clockwise:YES];
        [bezierPath addLineToPoint:center];
        [bezierPath closePath];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.lineWidth = 1;
        shapeLayer.fillColor = i % 2 == 0 ? WJColor(255, 244, 215, 0.9).CGColor : [UIColor whiteColor].CGColor;
        shapeLayer.path = bezierPath.CGPath;
        [_fansContainer.layer insertSublayer:shapeLayer atIndex:0];
    }
}
@end