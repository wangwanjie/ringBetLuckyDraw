//
//  GCStateCountItem.m
//  goldenGame
//
//  Created by CoderJay on 16/3/30.
//  Copyright © 2016年 golden. All rights reserved.
//

#import "GCStateCountItem.h"

@interface GCStateCountItem ()
@property (nonatomic, strong) UILabel *leftLabel; ///< 左边的label
@property (nonatomic, strong) UILabel *rightLabel; ///< 右边的label
@end

@implementation GCStateCountItem
- (instancetype)initWithLeftText:(NSString *)leftText rightText:(NSString *)rightText color:(UIColor *)color {
    if (self = [super init]) {
        UIFont *infoFont = IS_IPHONE_5 ? [UIFont systemFontOfSize:16] : [UIFont systemFontOfSize:IS_IPAD ? 24 : 18];
        
        self.leftLabel = ({
            UILabel *leftLabel = [[UILabel alloc] init];
            leftLabel.text = leftText;
            leftLabel.adjustsFontSizeToFitWidth = YES;
            leftLabel.font = infoFont;
            leftLabel.textColor = color;
            [self addSubview:leftLabel];
            leftLabel;
        });
        
        self.rightLabel = ({
            UILabel *rightLabel = [[UILabel alloc] init];
            rightLabel.text = rightText;
            rightLabel.textColor = color;
            rightLabel.adjustsFontSizeToFitWidth = YES;
            rightLabel.font = infoFont;
            rightLabel.textAlignment = NSTextAlignmentRight;
            [self addSubview:rightLabel];
            rightLabel;
        });
    }
    return self;
}

#pragma mark -
#pragma mark layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftLabel.frame = CGRectMake(0, 0, self.width * 0.6, self.height);
    self.rightLabel.frame = CGRectMake(_leftLabel.right, 0, self.width - _leftLabel.width, self.height);
}

#pragma mark -
#pragma mark getters and setters
- (void)setLeftText:(NSString *)leftText {
    _leftText = leftText;
    
    self.leftLabel.text = leftText;
}

- (void)setRightText:(NSString *)rightText {
    _rightText = rightText;
    
    self.rightLabel.text = rightText;
}
@end
