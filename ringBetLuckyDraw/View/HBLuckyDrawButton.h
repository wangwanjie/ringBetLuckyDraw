//
//  HBLuckyDrawButton.h
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/14.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJLuckyDrawDataModel;

@interface HBLuckyDrawButton : UIButton
@property (nonatomic, strong) WJLuckyDrawDataModel *luckyDrawDataModel; ///< 模型
@property (nonatomic, assign) CGFloat startAngle; ///< 扇区起始角度（）
@property (nonatomic, assign) CGFloat endAngle; ///< 扇区结束角度
@end
