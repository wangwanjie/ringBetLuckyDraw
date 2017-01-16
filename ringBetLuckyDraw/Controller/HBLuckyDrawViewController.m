//
//  HBLuckyDrawViewController.m
//  ringBetLuckyDraw
//
//  Created by CoderJay on 2017/1/12.
//  Copyright © 2017年 CoderJay. All rights reserved.
//

@interface LuckyDrawLeftCountLabel : UILabel
- (instancetype)initLuckyDrawLeftCountLabelWithText:(NSString *)text;
@end

@implementation LuckyDrawLeftCountLabel
#pragma mark -
#pragma mark convenient constructor
- (instancetype)initLuckyDrawLeftCountLabelWithText:(NSString *)text {
    if (self = [super init]) {
        self.textColor = [UIColor redColor];
        self.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:24];
        self.textAlignment = NSTextAlignmentCenter;
        self.text = text;
    }
    return self;
}
@end

NSInteger const kSpecialAwardCount = 1;
NSInteger const kFirstAwardCount = 4;
NSInteger const kSecondAwardCount = 6;
NSInteger const kThirdAwardCount = 10;
NSInteger const kFourthAwardCount = 15;

#import "HBLuckyDrawViewController.h"
#import "WJLuckyDraw.h"
#import "WJLuckyDrawDataModel.h"
#import "MJExtension.h"
#import "UIViewController+BackButtonHandler.h"
#import "SIAlertView.h"

@interface HBLuckyDrawViewController () <WJLuckyDrawDelegete, BackButtonHandlerProtocol>
@property (nonatomic, strong) NSMutableArray *dataSource; ///< 数据源
@property (nonatomic, strong) WJLuckyDraw *luckyDraw; ///< 转盘
@property (nonatomic, strong) LuckyDrawLeftCountLabel *specialLeftCount;
@property (nonatomic, strong) LuckyDrawLeftCountLabel *firstLeftCount;
@property (nonatomic, strong) LuckyDrawLeftCountLabel *secondLeftCount;
@property (nonatomic, strong) LuckyDrawLeftCountLabel *thirdLeftCount;
@property (nonatomic, strong) LuckyDrawLeftCountLabel *fourthLeftCount;
@end

@implementation HBLuckyDrawViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark -
#pragma mark layout
- (void)setupUI {
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"lucky_draw_background"].CGImage);
    
    _luckyDraw = [[WJLuckyDraw alloc] initLuckyDrawWithCenterButtonImage:@"start_lucky_draw" selectedImage:@"start_lucky_draw"];
    _luckyDraw.deleagte = self;
    _luckyDraw.dataSource = self.dataSource;
    [self.view addSubview:_luckyDraw];
    
    [_luckyDraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.view.height * 0.1575);
        make.width.equalTo(self.view).multipliedBy(0.413);
        make.height.equalTo(_luckyDraw.mas_width);
        make.left.equalTo(self.view).offset(self.view.width * 0.2580);
    }];
    
    _specialLeftCount = [[LuckyDrawLeftCountLabel alloc] initLuckyDrawLeftCountLabelWithText:[NSString stringWithFormat:@"%ld", kSpecialAwardCount]];
    _firstLeftCount = [[LuckyDrawLeftCountLabel alloc] initLuckyDrawLeftCountLabelWithText:[NSString stringWithFormat:@"%ld", kFirstAwardCount]];
    _secondLeftCount = [[LuckyDrawLeftCountLabel alloc] initLuckyDrawLeftCountLabelWithText:[NSString stringWithFormat:@"%ld", kSecondAwardCount]];
    _thirdLeftCount = [[LuckyDrawLeftCountLabel alloc] initLuckyDrawLeftCountLabelWithText:[NSString stringWithFormat:@"%ld", kThirdAwardCount]];
    _fourthLeftCount = [[LuckyDrawLeftCountLabel alloc] initLuckyDrawLeftCountLabelWithText:[NSString stringWithFormat:@"%ld", kFourthAwardCount]];
    [self.view addSubview:_specialLeftCount];
    [self.view addSubview:_firstLeftCount];
    [self.view addSubview:_secondLeftCount];
    [self.view addSubview:_thirdLeftCount];
    [self.view addSubview:_fourthLeftCount];
    
    CGFloat W = self.view.width;
    CGFloat H = self.view.height;
    CGFloat margin = H * 0.00641;
    _specialLeftCount.frame = CGRectMake(W * 0.8681, H * 0.1260, W * 0.046875, H * 0.03255);
    _firstLeftCount.frame = (CGRect){{_specialLeftCount.left, _specialLeftCount.bottom + margin}, _specialLeftCount.size};
    _secondLeftCount.frame = (CGRect){{_specialLeftCount.left, _firstLeftCount.bottom + margin}, _specialLeftCount.size};
    _thirdLeftCount.frame = (CGRect){{_specialLeftCount.left, _secondLeftCount.bottom + margin}, _specialLeftCount.size};
    _fourthLeftCount.frame = (CGRect){{_specialLeftCount.left, _thirdLeftCount.bottom + margin}, _specialLeftCount.size};
}

#pragma mark -
#pragma mark WJLuckyDrawDelegete
- (void)luckyDraw:(WJLuckyDraw *)luckyDraw result:(WJLuckyDrawDataModel *)model {
    switch (model.drawLevel) {
        case WJLuckyDrawDataModelDrawLevelSpecial: {
            _specialLeftCount.text = [NSString stringWithFormat:@"%ld", (unsigned long)[_specialLeftCount.text integerValue] - 1 <= 0 ? 0 : [_specialLeftCount.text integerValue] - 1];
            break;
        }
        case WJLuckyDrawDataModelDrawLevelFirst: {
            _firstLeftCount.text = [NSString stringWithFormat:@"%ld", (unsigned long)[_firstLeftCount.text integerValue] - 1 <= 0 ? 0 : [_firstLeftCount.text integerValue] - 1];
            break;
        }
        case WJLuckyDrawDataModelDrawLevelSecond: {
            _secondLeftCount.text = [NSString stringWithFormat:@"%ld", (unsigned long)[_secondLeftCount.text integerValue] - 1 <= 0 ? 0 : [_secondLeftCount.text integerValue] - 1];
            break;
        }
        case WJLuckyDrawDataModelDrawLevelThird: {
            _thirdLeftCount.text = [NSString stringWithFormat:@"%ld", (unsigned long)[_thirdLeftCount.text integerValue] - 1 <= 0 ? 0 : [_thirdLeftCount.text integerValue] - 1];
            break;
        }
        case WJLuckyDrawDataModelDrawLevelFourth: {
            _fourthLeftCount.text = [NSString stringWithFormat:@"%ld", (unsigned long)[_fourthLeftCount.text integerValue] - 1 <= 0 ? 0 : [_fourthLeftCount.text integerValue] - 1];
            break;
        }
    }
}

#pragma mark -
#pragma mark BackButtonHandlerProtocol
- (BOOL)navigationShouldPopOnBackButton {

    SIAlertView *alertView1 = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:@"返回上一界面将重置抽奖，请再次确认"];
    [alertView1 addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView1 addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        
        SIAlertView *alertView2 = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:@"所有已抽的奖将作废！！！请悉知"];
        [alertView2 addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView2 addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
        
            SIAlertView *alertView3 = [[SIAlertView alloc] initWithTitle:@"提示" andMessage:@"真的要返回吗？再次按下确定将返回上级界面并重置抽奖"];
            [alertView3 addButtonWithTitle:@"取消" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView3 addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDefault handler:^(SIAlertView *alertView) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            alertView3.titleColor = [UIColor redColor];
            alertView3.messageColor = [UIColor orangeColor];
            alertView3.buttonColor = [UIColor blueColor];
            alertView3.transitionStyle = SIAlertViewTransitionStyleBounce;
            [alertView3 show];
        }];
        alertView2.titleColor = [UIColor redColor];
        alertView2.messageColor = [UIColor orangeColor];
        alertView2.buttonColor = [UIColor blueColor];
        alertView2.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView2 show];

    }];
    alertView1.titleColor = [UIColor redColor];
    alertView1.messageColor = [UIColor orangeColor];
    alertView1.buttonColor = [UIColor blueColor];
    alertView1.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView1 show];
    
    return NO;
}

#pragma mark -
#pragma mark lazy load
/** @lazy 数据源 */
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
//        _dataSource = [WJLuckyDrawDataModel mj_objectArrayWithFilename:@"WJLuckyDrawDataModels.plist"];

        _dataSource = [NSMutableArray arrayWithCapacity:kSpecialAwardCount + kFirstAwardCount + kSecondAwardCount + kThirdAwardCount + kFourthAwardCount];
        for (NSUInteger i = 0; i < kSpecialAwardCount; i++) {
            WJLuckyDrawDataModel *luckyDrawDataModel = [WJLuckyDrawDataModel new];
            luckyDrawDataModel.descriptionStr = @"特等奖";
            luckyDrawDataModel.drawLevel = WJLuckyDrawDataModelDrawLevelSpecial;
            luckyDrawDataModel.backgroundImage = @"";
            [_dataSource addObject:luckyDrawDataModel];
        }
        for (NSUInteger i = 0; i < kFirstAwardCount; i++) {
            WJLuckyDrawDataModel *luckyDrawDataModel = [WJLuckyDrawDataModel new];
            luckyDrawDataModel.descriptionStr = @"一等奖";
            luckyDrawDataModel.drawLevel = WJLuckyDrawDataModelDrawLevelFirst;
            luckyDrawDataModel.backgroundImage = @"";
            [_dataSource addObject:luckyDrawDataModel];
        }
        for (NSUInteger i = 0; i < kSecondAwardCount; i++) {
            WJLuckyDrawDataModel *luckyDrawDataModel = [WJLuckyDrawDataModel new];
            luckyDrawDataModel.descriptionStr = @"二等奖";
            luckyDrawDataModel.drawLevel = WJLuckyDrawDataModelDrawLevelSecond;
            luckyDrawDataModel.backgroundImage = @"";
            [_dataSource addObject:luckyDrawDataModel];
        }
        for (NSUInteger i = 0; i < kThirdAwardCount; i++) {
            WJLuckyDrawDataModel *luckyDrawDataModel = [WJLuckyDrawDataModel new];
            luckyDrawDataModel.descriptionStr = @"三等奖";
            luckyDrawDataModel.drawLevel = WJLuckyDrawDataModelDrawLevelThird;
            luckyDrawDataModel.backgroundImage = @"";
            [_dataSource addObject:luckyDrawDataModel];
        }
        for (NSUInteger i = 0; i < kFourthAwardCount; i++) {
            WJLuckyDrawDataModel *luckyDrawDataModel = [WJLuckyDrawDataModel new];
            luckyDrawDataModel.descriptionStr = @"四等奖";
            luckyDrawDataModel.drawLevel = WJLuckyDrawDataModelDrawLevelFourth;
            luckyDrawDataModel.backgroundImage = @"";
            [_dataSource addObject:luckyDrawDataModel];
        }
        // 乱序
        for (NSInteger i = _dataSource.count - 1; i > 0; i--) {
            [_dataSource exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t)i + 1)];
        }
    }
    return _dataSource;
}
@end