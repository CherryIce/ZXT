//
//  HWGuidePageManager.m
//  TransparentGuidePage
//
//  Created by wangqibin on 2018/4/20.
//  Copyright © 2018年 sensmind. All rights reserved.
//

#import "HWGuidePageManager.h"

#define KMainW [UIScreen mainScreen].bounds.size.width
#define KMainH [UIScreen mainScreen].bounds.size.height

#define KScreenRate (375 / KMainW)
#define KSuitFloat(float) (float / KScreenRate)
#define KSuitSize(width, height) CGSizeMake(width / KScreenRate, height / KScreenRate)
#define KSuitPoint(x, y) CGPointMake(x / KScreenRate, y / KScreenRate)
#define KSuitRect(x, y, width, heigth) CGRectMake(x / KScreenRate, y / KScreenRate, width / KScreenRate, heigth / KScreenRate)

@interface HWGuidePageManager ()

@property (nonatomic, copy) FinishBlock finish;
@property (nonatomic, copy) NSString *guidePageKey;
@property (nonatomic, assign) HWGuidePageType guidePageType;

@end

@implementation HWGuidePageManager

+ (instancetype)shareManager
{
    static HWGuidePageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)showGuidePageWithType:(HWGuidePageType)type rect:(CGRect)rect
{
    [self creatControlWithType:type rect:rect completion:NULL];
}

- (void)showGuidePageWithType:(HWGuidePageType)type rect:(CGRect)rect completion:(FinishBlock)completion
{
    [self creatControlWithType:type rect:rect completion:completion];
}

- (void)creatControlWithType:(HWGuidePageType)type rect:(CGRect)rect completion:(FinishBlock)completion
{
    _finish = completion;

    // 遮盖视图
    CGRect frame = [UIScreen mainScreen].bounds;
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7f];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    //跳过按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(20, 40, 52, 24)];
    [button setTitle:@"跳过" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 14];
    button.layer.cornerRadius = 4;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button addTarget:self action:@selector(tiaoGuo:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
    // 信息提示视图
    UIImageView *imgView = [[UIImageView alloc] init];
    [bgView addSubview:imgView];
    
    // 第一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    switch (type) {
        case HWGuidePageTypeHome:
            // 下一个路径，圆形
            [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(bgView.centerX, bgView.centerY) radius:rect.size.width/2 startAngle:0 endAngle:2 * M_PI clockwise:NO]];
            imgView.frame = KSuitRect(220, kScreenHeight/2 - 210, 100, 100);
            imgView.image = [UIImage imageNamed:@"hi"];
            _guidePageKey = HWGuidePageHomeKey;
            break;
            
        case HWGuidePageTypeMajor:
            // 下一个路径，矩形
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5] bezierPathByReversingPath]];
            imgView.frame = CGRectMake(rect.origin.x + rect.size.width/2, rect.origin.y - 120 - 10, 120, 120);
            imgView.image = [UIImage imageNamed:@"ly"];
            _guidePageKey = HWGuidePageMajorKey;
            break;
        case HWGuidePageTypeThree:
            // 下一个路径，矩形
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:KSuitRect(5, 436, 90, 40) cornerRadius:5] bezierPathByReversingPath]];
            imgView.frame = KSuitRect(100, 320, 120, 120);
            imgView.image = [UIImage imageNamed:@"ly"];
            _guidePageKey = HWGuidePageThreeKey;
            break;
        case HWGuidePageTypeFour:
            // 下一个路径，矩形
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:KSuitRect(5, 436, 90, 40) cornerRadius:5] bezierPathByReversingPath]];
            imgView.frame = KSuitRect(100, 320, 120, 120);
            imgView.image = [UIImage imageNamed:@"ly"];
            _guidePageKey = HWGuidePageFourKey;
            break;
        case HWGuidePageTypeFive:
            // 下一个路径，矩形
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:KSuitRect(5, 436, 90, 40) cornerRadius:5] bezierPathByReversingPath]];
            imgView.frame = KSuitRect(100, 320, 120, 120);
            imgView.image = [UIImage imageNamed:@"ly"];
            _guidePageKey = HWGuidePageFiveKey;
            break;
        case HWGuidePageTypeSix:
            // 下一个路径，矩形
            [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:KSuitRect(5, 436, 90, 40) cornerRadius:5] bezierPathByReversingPath]];
            imgView.frame = KSuitRect(100, 320, 120, 120);
            imgView.image = [UIImage imageNamed:@"ly"];
            _guidePageKey = HWGuidePageSixKey;
            break;
        default:
            break;
    }
    
    // 绘制透明区域
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    [bgView.layer setMask:shapeLayer];
}

- (void)tap:(UITapGestureRecognizer *)recognizer
{
    UIView *bgView = recognizer.view;
    [bgView removeFromSuperview];
    [bgView removeGestureRecognizer:recognizer];
    [[bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    bgView = nil;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_guidePageKey];
    
    if (_finish) _finish();
}

- (void) tiaoGuo:(UIButton *) sender {
    UIView *bgView = sender.superview;
    [bgView removeFromSuperview];
    [[bgView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    bgView = nil;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_guidePageKey];
}

@end
