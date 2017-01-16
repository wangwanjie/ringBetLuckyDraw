//
//  HBLuckyDrawButton.m
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/14.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import "HBLuckyDrawButton.h"
#include <math.h>

@interface HBLuckyDrawButton ()
@end

@implementation HBLuckyDrawButton
#pragma mark -
#pragma mark life cycle
- (void)commonInit {
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}
@end
