//
//  GDPondView.m
//  goldenGame
//
//  Created by CoderJay on 16/1/21.
//  Copyright © 2016年 golden. All rights reserved.
//

#import "GCPondButton.h"
#import "UIImage+ColorAtPixel.h"

static const CGFloat kAlphaVisibleThreshold = 0.1;

@interface GCPondButton ()

@property (nonatomic, assign) CGPoint previousTouchPoint;
@property (nonatomic, assign) BOOL previousTouchHitTestResponse;
@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UIImage *buttonBackground;

- (void)updateImageCacheForCurrentState;
- (void)resetHitTestCache;
@end

@implementation GCPondButton
#pragma mark -
#pragma mark life cycle
- (instancetype)initWithBgImage:(NSString *)bgImage highlightImage:(NSString *)highlightImage itemCode:(NSString *)itemCode poolCode:(NSString *)poolCode {
    if (self = [super init]) {
        
        [self updateImageCacheForCurrentState];
        [self resetHitTestCache];
        
    }
    return self;
}

#pragma mark - Hit testing
- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image {
    // Correct point to take into account that the image does not have to be the same size
    // as the button. See https://github.com/ole/OBShapedButton/issues/1
    CGSize iSize = image.size;
    CGSize bSize = self.bounds.size;
    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    
    UIColor *pixelColor = [image colorAtPixel:point];
    CGFloat alpha = 0.0;
    
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        // available from iOS 5.0
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    }
    else {
        // for iOS < 5.0
        // In iOS 6.1 this code is not working in release mode, it works only in debug
        // CGColorGetAlpha always return 0.
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha = CGColorGetAlpha(cgPixelColor);
    }
    return alpha >= kAlphaVisibleThreshold;
}


// UIView uses this method in hitTest:withEvent: to determine which subview should receive a touch event.
// If pointInside:withEvent: returns YES, then the subview’s hierarchy is traversed; otherwise, its branch
// of the view hierarchy is ignored.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // Return NO if even super returns NO (i.e., if point lies outside our bounds)
    BOOL superResult = [super pointInside:point withEvent:event];
    if (!superResult) {
        return superResult;
    }
    
    // Don't check again if we just queried the same point
    // (because pointInside:withEvent: gets often called multiple times)
    if (CGPointEqualToPoint(point, self.previousTouchPoint)) {
        return self.previousTouchHitTestResponse;
    }
    else {
        self.previousTouchPoint = point;
    }
    
    BOOL response = NO;
    
    if (self.buttonImage == nil && self.buttonBackground == nil) {
        response = YES;
    }
    else if (self.buttonImage != nil && self.buttonBackground == nil) {
        response = [self isAlphaVisibleAtPoint:point forImage:self.buttonImage];
    }
    else if (self.buttonImage == nil && self.buttonBackground != nil) {
        response = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
    }
    else {
        if ([self isAlphaVisibleAtPoint:point forImage:self.buttonImage]) {
            response = YES;
        } else {
            response = [self isAlphaVisibleAtPoint:point forImage:self.buttonBackground];
        }
    }
    
    self.previousTouchHitTestResponse = response;
    return response;
}


#pragma mark - Accessors

// Reset the Hit Test Cache when a new image is assigned to the button
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [super setBackgroundImage:image forState:state];
    [self updateImageCacheForCurrentState];
    [self resetHitTestCache];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateImageCacheForCurrentState];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self updateImageCacheForCurrentState];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateImageCacheForCurrentState];
}


#pragma mark - Helper methods

- (void)updateImageCacheForCurrentState {
    _buttonBackground = [self currentBackgroundImage];
    _buttonImage = [self currentImage];
}

- (void)resetHitTestCache {
    self.previousTouchPoint = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
    self.previousTouchHitTestResponse = NO;
}

@end