//
//  HBMainViewController.m
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/12.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

#import "HBMainViewController.h"
#import "GCCommonButton.h"
#import "HBLuckyDrawViewController.h"
#import "GCStateCountItem.h"

@interface HBMainViewController ()
@property (strong, nonatomic) GCCommonButton *startLuckyDraw;    ///< 开始抽奖按钮
@end

@implementation HBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark -
#pragma mark layout
- (void)setupUI {
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"main_background"].CGImage);
    
    _startLuckyDraw = [[GCCommonButton alloc] initWithTitle:nil image:nil highlightImage:@"" bgImage:@"start" highlightBgImage:@"stop"];
    [self.view addSubview:_startLuckyDraw];
    [_startLuckyDraw addTarget:self action:@selector(startLuckyDrawing) forControlEvents:UIControlEventTouchUpInside];
    
    [_startLuckyDraw mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).multipliedBy(0.2685);
        make.height.equalTo(self.view).multipliedBy(0.1093);
        make.centerX.equalTo(self.view).multipliedBy(0.593);
        make.top.equalTo(self.view).offset(self.view.height * 0.822);
    }];
}

#pragma mark -
#pragma mark event response
- (void)startLuckyDrawing {
    HBLuckyDrawViewController *luckyVc = [[HBLuckyDrawViewController alloc] init];
    
    [self.navigationController pushViewController:luckyVc animated:YES];
}
@end
