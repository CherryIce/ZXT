//
//  UIView+ICEZwt.m
//  ZXT
//
//  Created by 1 on 2019/5/20.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "UIView+ICEZwt.h"

#import <objc/runtime.h>
#import <ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

@interface UIView ()

/** 用来记录UIScrollView最初的scrollEnabled */
@property (nonatomic, assign) BOOL cq_originalScrollEnabled;

@end

@implementation UIView (ICEZwt)

static void *placeholderViewKey = &placeholderViewKey;
static void *originalScrollEnabledKey = &originalScrollEnabledKey;

- (UIView *)cq_placeholderView {
    return objc_getAssociatedObject(self, &placeholderViewKey);
}

- (void)setCq_placeholderView:(UIView *)cq_placeholderView {
    objc_setAssociatedObject(self, &placeholderViewKey, cq_placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cq_originalScrollEnabled {
    return [objc_getAssociatedObject(self, &originalScrollEnabledKey) boolValue];
}

- (void)setCq_originalScrollEnabled:(BOOL)cq_originalScrollEnabled {
    objc_setAssociatedObject(self, &originalScrollEnabledKey, @(cq_originalScrollEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - 展示UIView或其子类的占位图
/**
 展示UIView或其子类的占位图
 
 @param type 占位图类型
 @param reloadBlock 重新加载回调的block
 */
- (void)shoZWtWithType:(ZwtType)type descr:(nullable NSString *)descr reloadBlock:(void(^)(void))reloadBlock {
    // 如果是UIScrollView及其子类，占位图展示期间禁止scroll
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        // 先记录原本的scrollEnabled
        self.cq_originalScrollEnabled = scrollView.scrollEnabled;
        // 再将scrollEnabled设为NO
        scrollView.scrollEnabled = NO;
    }
    
    //------- 占位图 -------//
    if (self.cq_placeholderView) {
        [self.cq_placeholderView removeFromSuperview];
        self.cq_placeholderView = nil;
    }
    self.cq_placeholderView = [[UIView alloc] init];
    [self addSubview:self.cq_placeholderView];
    self.cq_placeholderView.backgroundColor = [UIColor whiteColor];
    self.cq_placeholderView.center = self.center;
    self.cq_placeholderView.frame = self.bounds;
    
    //------- 图标 -------//
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.cq_placeholderView addSubview:imageView];
    
    imageView.sd_layout.leftSpaceToView(self.cq_placeholderView, self.cq_placeholderView.centerX - 50).topSpaceToView(self.cq_placeholderView, self.cq_placeholderView.centerY - 60).widthIs(100).heightIs(100);
    imageView.center = CGPointMake(self.cq_placeholderView.centerX, self.cq_placeholderView.centerY-90);
    
    //------- 描述 -------//
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.textColor = [UIColor lightGrayColor];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 0;
    [self.cq_placeholderView addSubview:descLabel];
    
    descLabel.sd_layout.leftSpaceToView(self.cq_placeholderView, 100).topSpaceToView(imageView, 10).rightSpaceToView(self.cq_placeholderView, 100).autoHeightRatio(0);
    
    //------- 重新加载button -------//
    UIButton *reloadButton = [[UIButton alloc] init];
    [self.cq_placeholderView addSubview:reloadButton];
    [reloadButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    
    @weakify(self);
    [[reloadButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        // 执行block回调
        if (reloadBlock) {
            reloadBlock();
        }
        // 从父视图移除
        [self.cq_placeholderView removeFromSuperview];
        self.cq_placeholderView = nil;
        // 复原UIScrollView的scrollEnabled
        if ([self isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)self;
            scrollView.scrollEnabled = self.cq_originalScrollEnabled;
        }
    }];
    reloadButton.sd_layout.leftSpaceToView(self.cq_placeholderView, self.cq_placeholderView.centerX - 60).topSpaceToView(descLabel, 10).widthIs(120).heightIs(30);
    
    //------- 根据type设置不同UI 图片名字可传进来 -------//
    switch (type) {
        case NoNetwork: // 网络不好
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"没网络" ofType:@"png"];
            imageView.image = [UIImage imageWithContentsOfFile:path];
            descLabel.text = @"请检查你的网络连接";
        }
            break;
            
        case NoDataSorce: // 没数据
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"没数据" ofType:@"png"];
            imageView.image = [UIImage imageWithContentsOfFile:path];
            descLabel.text = descr;
        }
            break;
        default:
            break;
    }
}


#pragma mark - 主动移除占位图
/**
 主动移除占位图
 占位图会在你点击“重新加载”按钮的时候自动移除，你也可以调用此方法主动移除
 */
- (void)removeZwt {
    if (self.cq_placeholderView) {
        [self.cq_placeholderView removeFromSuperview];
        self.cq_placeholderView = nil;
    }
    // 复原UIScrollView的scrollEnabled
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = self.cq_originalScrollEnabled;
    }
}

@end
