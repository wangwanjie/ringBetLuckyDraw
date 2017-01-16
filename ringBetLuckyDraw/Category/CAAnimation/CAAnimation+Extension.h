//
//  CALayer+Animation.h
//  goldenGame
//
//  Created by CoderJay on 16/4/12.
//  Copyright © 2016年 golden. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Extension)
/**
 *  为图层添加动画
 *
 *  @param time        动画时长
 *  @param repeatCount 重复次数
 *  @param keyPath     keyPath
 *  @param fromValue   初始值
 *  @param toVlaue     结束直
 */
+ (CABasicAnimation *)animationWithDuration:(float)time repeatCount:(float)repeatCount keyPath:(NSString *)keyPath fromValue:(id)fromValue toVlaue:(id)toVlaue;
/**
 *  创建CASpringAnimation动画
 *
 *  @param keyPath         关键路径
 *  @param mass            质量越大，惯性越大
 *  @param damping         越大停止越快
 *  @param stiffness       越大运动越快
 *  @param initialVelocity 速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
 *  @param fromValue       开始值
 *  @param toValue         结束值
 */
+ (CASpringAnimation *)springAnimationWithKeyPath:(NSString *)keyPath mass:(CGFloat)mass damping:(CGFloat)damping stiffness:(CGFloat)stiffness initialVelocity:(CGFloat)initialVelocity fromValue:(id)fromValue toValue:(id)toValue;
@end
