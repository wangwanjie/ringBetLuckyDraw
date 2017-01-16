//
//  GCCommonButton.h
//  goldenGame
//
//  Created by CoderJay on 16/4/12.
//  Copyright © 2016年 golden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCCommonButton : UIButton
/**
 *  创建一个按钮
 *
 *  @param title            标题
 *  @param image            图片
 *  @param highlightImage   高亮图片
 *  @param bgImage          背景图片
 *  @param highlightBgImage 高亮背景图片
 */
- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image highlightImage:(NSString *)highlightImage bgImage:(NSString *)bgImage highlightBgImage:(NSString *)highlightBgImage;

@property (nonatomic, assign) BOOL separateIntoUpAndDown;       ///< 是否图片与标题上下分布
@property (nonatomic, assign) BOOL separateIntoLeftAndRight;    ///< 是否标题图片左右分布（图片在右）
@property (nonatomic, assign) BOOL keepTitleLabelLeftAlignment; ///< 标题居左
@property (nonatomic, assign) BOOL keepCOntentCenterAlignment;  ///< 内容居中
@end
