//
//  CALayer+Associated.m
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/14.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import "CALayer+Associated.h"
#import <objc/runtime.h>

@implementation CALayer (Associated)
static char tagKey;

- (void)setTag:(NSNumber *)tag {
    objc_setAssociatedObject(self, &tagKey, tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)tag {
    return objc_getAssociatedObject(self, &tagKey);
}
@end
