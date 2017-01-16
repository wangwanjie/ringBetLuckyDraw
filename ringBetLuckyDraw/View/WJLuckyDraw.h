//
//  WJLuckyDraw.h
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/13.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJLuckyDraw, WJLuckyDrawDataModel;

@protocol WJLuckyDrawDelegete <NSObject>
@optional
- (void)luckyDraw:(WJLuckyDraw *)luckyDraw result:(WJLuckyDrawDataModel *)model;
@end

@interface WJLuckyDraw : UIView
@property (nonatomic, strong) NSMutableArray *dataSource; ///< 数据源
@property (nonatomic, weak) id<WJLuckyDrawDelegete> deleagte;  ///< 代理

- (instancetype)initLuckyDrawWithCenterButtonImage:(NSString *)image selectedImage:(NSString *)selectedImage;
@end
