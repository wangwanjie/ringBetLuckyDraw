//
//  WJLuckyDrawDataModel.m
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/13.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import "WJLuckyDrawDataModel.h"

@implementation WJLuckyDrawDataModel
- (NSString *)description {
    return [NSString stringWithFormat:@"%@----等级:%lu-----背景图: %@", _descriptionStr, (unsigned long)_drawLevel, _backgroundImage];
}
@end
