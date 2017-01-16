//
//  WJLuckyDrawDataModel.h
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/13.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

typedef NS_ENUM(NSUInteger, WJLuckyDrawDataModelDrawLevel) {
    WJLuckyDrawDataModelDrawLevelSpecial = 1,   ///< 特等奖
    WJLuckyDrawDataModelDrawLevelFirst,         ///< 一等奖
    WJLuckyDrawDataModelDrawLevelSecond,        ///< 二等奖
    WJLuckyDrawDataModelDrawLevelThird,         ///< 三等奖
    WJLuckyDrawDataModelDrawLevelFourth         ///< 四等奖
};

#import <Foundation/Foundation.h>

@interface WJLuckyDrawDataModel : NSObject
@property (nonatomic, copy  ) NSString                      *descriptionStr;///< 描述
@property (nonatomic, assign) WJLuckyDrawDataModelDrawLevel drawLevel;///< 奖级
@property (nonatomic, copy) NSString *backgroundImage; ///< 背景图
@end
