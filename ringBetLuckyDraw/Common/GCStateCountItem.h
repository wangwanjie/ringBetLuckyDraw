//
//  GCStateCountItem.h
//  goldenGame
//
//  Created by CoderJay on 16/3/30.
//  Copyright © 2016年 golden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCStateCountItem : UIView
@property (nonatomic, copy) NSString *leftText;     ///< 左边文字
@property (nonatomic, copy) NSString *rightText;    ///< 右边文字
- (instancetype)initWithLeftText:(NSString *)leftText rightText:(NSString *)rightText color:(UIColor *)color;
@end
