//
//  CALayer+Associated.h
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/14.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Associated)
- (void) setTag:(NSNumber *)tag;

- (NSNumber *)tag;
@end
