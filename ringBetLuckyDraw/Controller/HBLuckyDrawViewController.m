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
#import "FCAlertView.h"

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
    @WJWeakObj(self);
    FCAlertView *alert1 = [[FCAlertView alloc] init];
    [alert1 showAlertWithTitle:@"提示" withSubtitle:@"返回上一界面将重置抽奖，请再次确认" withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
    alert1.hideDoneButton = YES;
    alert1.bounceAnimations = YES;
    alert1.colorScheme = alert1.flatOrange;
    [alert1 makeAlertTypeCaution];
    [alert1 addButton:@"取消" withActionBlock:nil];
    [alert1 addButton:@"确定" withActionBlock:^{
        FCAlertView *alert2 = [[FCAlertView alloc] init];
        [alert2 showAlertWithTitle:@"提示" withSubtitle:@"所有已抽的奖将作废！！！请悉知" withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
        alert2.hideDoneButton = YES;
        alert2.bounceAnimations = YES;
        alert2.colorScheme = alert2.flatOrange;
        [alert2 makeAlertTypeCaution];
        [alert2 addButton:@"取消" withActionBlock:nil];
        [alert2 addButton:@"确定" withActionBlock:^{
            FCAlertView *alert3 = [[FCAlertView alloc] init];
            [alert3 showAlertWithTitle:@"提示" withSubtitle:@"真的要返回吗？再次按下确定将返回上级界面并重置抽奖" withCustomImage:nil withDoneButtonTitle:nil andButtons:nil];
            alert3.hideDoneButton = YES;
            alert3.bounceAnimations = YES;
            alert3.colorScheme = alert3.flatOrange;
            [alert3 makeAlertTypeCaution];
            [alert3 addButton:@"取消" withActionBlock:nil];
            [alert3 addButton:@"确定" withActionBlock:^{
                [selfWeak.navigationController popViewControllerAnimated:YES];
            }];
        }];
    }];
    
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
