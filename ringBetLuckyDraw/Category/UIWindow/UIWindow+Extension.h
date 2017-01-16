//
//  UIWindow+Extension.h
//  goldenGame
//
//  Created by CoderJay on 16/1/3.
//  Copyright © 2016年 golden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Extension)
/**
 *  切换至目标控制器
 *
 *  @param destViewController 目标控制器
 */
+ (void)switchRootViewControllerTo:(UIViewController *)destViewController;
@end
