//
//  UIViewController+BackButtonHandler_h.h
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/14.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
- (BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end
