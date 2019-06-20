//
//  ICEScrollPageView.h
//  ZXT
//
//  Created by 1 on 2019/6/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WBPopOverView.h"

#import "CWCarousel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ICEScrollPageView : UIView

@property (nonatomic, strong) CWCarousel *carousel;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource;

@end

NS_ASSUME_NONNULL_END
