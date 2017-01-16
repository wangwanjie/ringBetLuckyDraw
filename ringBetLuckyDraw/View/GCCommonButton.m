//
//  GCCommonButton.m
//  goldenGame
//
//  Created by CoderJay on 16/4/12.
//  Copyright © 2016年 golden. All rights reserved.
//

#import "GCCommonButton.h"
#import "UIImage+Extension.h"

@interface GCCommonButton ()
@property (nonatomic, copy) NSString *title; ///< 标题
@property (nonatomic, copy) NSString *image; ///< 正常状态图片名
@end

@implementation GCCommonButton
- (instancetype)initWithTitle:(NSString *)title image:(NSString *)image highlightImage:(NSString *)highlightImage bgImage:(NSString *)bgImage highlightBgImage:(NSString *)highlightBgImage {
    if (self = [super init]) {
        
        _title = title;
        _image = image;
        
        // 无标题
        if (!title) {
            [self.titleLabel removeFromSuperview];
        } else {
            self.titleLabel.font = [UIFont fontWithName:GCFontName size:IS_IPAD ? 24 : 18];
            [self setTitle:title forState:UIControlStateNormal];
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        if (bgImage) {
             [self setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
        }
        if (highlightBgImage) {
            [self setBackgroundImage:[UIImage imageNamed:highlightBgImage] forState:UIControlStateHighlighted];
            [self setBackgroundImage:[UIImage imageNamed:highlightBgImage] forState:UIControlStateSelected];
            [self setBackgroundImage:[UIImage imageNamed:highlightBgImage] forState:UIControlStateDisabled];
        }
        
        // 无图片
        if (!image) {
            [self.imageView removeFromSuperview];
            
            // 没图片文字居中
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        } else {
            
            // 图片居中
            self.imageView.contentMode = UIViewContentModeCenter;
            
            self.imageView.clipsToBounds = NO;
            
            // 设置图片
            [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            
            // 有图片文字居左
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            
            if (highlightImage) {
                 [self setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
            }
        }
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark -
#pragma mark layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 只有图片
    if (!_title) {
        
        self.imageView.frame = self.bounds;
        return;
    }
    
    // 只有文字
    if (!_image) {
        self.titleLabel.frame = self.bounds;
        
        if (self.keepTitleLabelLeftAlignment) {
            self.titleLabel.frame = CGRectMake(10, 0, self.width - 10, self.height);
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
        }
        return;
    }
    
    if (self.separateIntoUpAndDown) { // 上下排布图片与标题
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.frame = CGRectMake(0, 0, self.width, self.height * 0.625);
        self.titleLabel.frame = CGRectMake(0, self.imageView.bottom, self.width, self.height - self.imageView.bottom);
        
    } else if (self.separateIntoLeftAndRight) { // 标题与图片左右分布
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.frame = CGRectMake(self.width - self.height, 0, self.height, self.height);
        self.titleLabel.frame = CGRectMake(0, 0, self.width - self.imageView.width, self.height);
        
    } else if (self.keepCOntentCenterAlignment) { // 内容居中
        self.contentMode = UIViewContentModeCenter;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        
    } else {
        // 标题图片都在
        self.imageView.frame = CGRectMake(0, 0, self.height, self.height);
        self.titleLabel.frame = CGRectMake(self.imageView.right, 0, self.width - self.imageView.width, self.height);
    }
}
@end
