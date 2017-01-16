//
//  NSString+Extension.m
//  goldenGame
//
//  Created by CoderJay on 16/1/3.
//  Copyright © 2016年 golden. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 *     返回CGSize
 *
 *     @param text 文字
 *     @param font 字体大小
 *     @param maxW 宽度限制
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);    // Y方向无限制
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];    // 单行
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}
- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

+ (NSString *)groupedThousandsDigitStringWithStr:(NSString *)digitString {
    
    // 判断小数部位
    NSRange rangeOfPoint = [digitString rangeOfString:@"."];
    NSString *pointStr = @"";
    if (rangeOfPoint.length >= 1) {
        pointStr = [digitString substringFromIndex:rangeOfPoint.location];
    }
    
    // 去掉小数部位
    digitString = [digitString substringToIndex:rangeOfPoint.location];
    
    // 去掉小数位后长度小于3直接返回原字符
    if (digitString.length <= 3) return [digitString stringByAppendingString:pointStr];
    
    NSMutableString *processString = [NSMutableString stringWithString:digitString];
    
    NSInteger location = processString.length - 3;
    NSMutableArray *processArray = [NSMutableArray array];
    while (location >= 0) {
        NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
        
        [processArray addObject:temp];
        if (location < 3 && location > 0) {
            NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
            [processArray addObject:t];
        }
        location -= 3;
    }
    
    NSMutableArray *resultsArray = [NSMutableArray array];
    NSInteger k = 0;
    for (NSString *str in processArray) {
        k++;
        NSMutableString *tmp = [NSMutableString stringWithString:str];
        if (str.length > 2 && k < processArray.count ) {
            [tmp insertString:@"," atIndex:0];
            [resultsArray addObject:tmp];
        } else {
            [resultsArray addObject:tmp];
        }
    }
    
    NSMutableString *resultString = [NSMutableString string];
    for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--) {
        NSString *tmp = [resultsArray objectAtIndex:i];
        [resultString appendString:tmp];
    }
    
    return [resultString stringByAppendingString:pointStr];
}
@end
