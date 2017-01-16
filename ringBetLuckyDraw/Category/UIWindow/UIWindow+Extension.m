//
//  UIWindow+Extension.m
//  goldenGame
//
//  Created by CoderJay on 16/1/3.
//  Copyright © 2016年 golden. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "CAAnimation+Extension.h"

@implementation UIWindow (Extension)
+ (void)switchRootViewControllerTo:(UIViewController *)destViewController {
    
    UIApplication *application = [UIApplication sharedApplication];
    // 设置屏幕是否常亮
    if ([destViewController isKindOfClass:NSClassFromString(@"GCLoginController")]) {
        application.idleTimerDisabled = NO;
    } else if ([destViewController isKindOfClass:NSClassFromString(@"GCNavigationController")]) {
        application.idleTimerDisabled = YES;
    }
    
    // 主窗口
    UIWindow *mainWindow = application.keyWindow;
    
    // 先销毁原来的根控制器
    mainWindow.rootViewController = nil;
    
    mainWindow.rootViewController = destViewController;
    
    CAAnimation *animation;
    if (iOS9OrLater) {
        animation = [CAAnimation springAnimationWithKeyPath:@"transform.scale" mass:1.f damping:20.f stiffness:200.f initialVelocity:0.9 fromValue:@(0) toValue:@(1.f)];
    }
    else {
        animation = [CAAnimation animationWithDuration:0.5 repeatCount:1 keyPath:@"transform.scale" fromValue:@(0) toVlaue:@(1.f)];
    }
    [mainWindow.rootViewController.view.layer addAnimation:animation forKey:nil];
}
@end
