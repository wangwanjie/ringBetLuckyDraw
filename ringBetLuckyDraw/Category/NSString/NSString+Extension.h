//
//  NSString+Extension.h
//  goldenGame
//
//  Created by CoderJay on 16/1/3.
//  Copyright © 2016年 golden. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *     返回CGSize
 *
 *     @param text 文字
 *     @param font 字体大小
 *     @param maxW 宽度限制
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/**
 *  返回size
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/** 计算文件\文件夹内容大小 */
- (NSInteger)fileSize;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  将一个数字转为千位分隔符隔开的字符串
 *
 *  @param digitString 原字符串
 *
 *  @return 千位隔开的字符串
 */
+ (NSString *)groupedThousandsDigitStringWithStr:(NSString *)digitString;
@end
