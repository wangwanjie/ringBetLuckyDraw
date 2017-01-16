//
//  WJWeakTimer.h
//  goldenGame
//
//  Created by CoderJay on 16/1/3.
//  Copyright © 2016年 golden. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WJTimerHandler)(id userInfo);

@interface WJWeakTimer : NSObject

/**
 *  创建一个不会强引用self的定时器
 */
+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

/**
 *  创建一个在BLOCK执行目标事件的定时器
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(WJTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

@end
