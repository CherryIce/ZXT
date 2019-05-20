//
//  ICELoadingView.m
//  ZXT
//
//  Created by 1 on 2019/5/20.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICELoadingView.h"

@interface ICELoadingView ()
//method 1
@property (nonatomic , retain) UIActivityIndicatorView * loadJH;
//method 2
@property (nonatomic , retain) CAShapeLayer *bottomShapeLayer;

@property (nonatomic , retain) CAShapeLayer *ovalShapeLayer;

@end

@implementation ICELoadingView

#pragma mark --- 1 ---
+ (ICELoadingView *) shareInstance{
    return [[self alloc] initWithFrame:CGRectZero];
}

- (UIActivityIndicatorView *)loadJH{
    if (!_loadJH) {
        _loadJH = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _loadJH.center = self.center;
    }
    return _loadJH;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];
    if (self) {
        [self setIndicatorViewUI];
    }
    return self;
}

- (void) setIndicatorViewUI {
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 5;
    self.alpha = 0.5;
    [self addSubview:self.loadJH];
}

+ (void) showInView:(UIView *)view{
    ICELoadingView * load = [ICELoadingView shareInstance];
    [view addSubview:load];
    load.center = view.center;
    [load.loadJH startAnimating];
}

+ (void) disMissView:(UIView *)view{
    for (UIView * class in view.subviews) {
        if ([class isKindOfClass:[ICELoadingView class]]) {
            ICELoadingView * v = (ICELoadingView *)class;
            [v.loadJH stopAnimating];
            v.loadJH = nil;
            [v removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
