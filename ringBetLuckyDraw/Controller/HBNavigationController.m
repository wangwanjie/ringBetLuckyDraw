//
//  HBNavigationController.m
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/12.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import "HBNavigationController.h"

@interface HBNavigationController ()

@end

@implementation HBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 状态栏透明
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
}
@end
