//
// CALayer+Frame.h
//  工具分类
//
//  Created by CoderJay on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//  提供直接修改frame参数

#import <UIKit/UIKit.h>

@interface CALayer (Frame)
@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat bottom;

@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;

@property(nonatomic, assign) CGPoint origin;
@property(nonatomic, assign) CGSize size;
@end
