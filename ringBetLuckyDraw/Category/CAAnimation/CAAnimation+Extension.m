//
//  CALayer+Animation.m
//  goldenGame
//
//  Created by CoderJay on 16/4/12.
//  Copyright © 2016年 golden. All rights reserved.
//

#import "CAAnimation+Extension.h"

@implementation CAAnimation (Extension)
+ (CABasicAnimation *)animationWithDuration:(float)time repeatCount:(float)repeatCount keyPath:(NSString *)keyPath fromValue:(id)fromValue toVlaue:(id)toVlaue {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue = toVlaue;
    animation.autoreverses = NO;
    animation.duration = time;
    animation.repeatCount = repeatCount;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}

+ (CASpringAnimation *)springAnimationWithKeyPath:(NSString *)keyPath mass:(CGFloat)mass damping:(CGFloat)damping stiffness:(CGFloat)stiffness initialVelocity:(CGFloat)initialVelocity fromValue:(id)fromValue toValue:(id)toValue {
    
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:keyPath];
    springAnimation.mass = mass;
    springAnimation.damping = damping;
    springAnimation.stiffness = stiffness;
    springAnimation.initialVelocity = initialVelocity;
    springAnimation.duration = springAnimation.settlingDuration;
    springAnimation.fromValue  = fromValue;
    springAnimation.toValue  = toValue;
    
    springAnimation.removedOnCompletion = NO;
    springAnimation.fillMode = kCAFillModeForwards;
    
    return springAnimation;
}
@end
