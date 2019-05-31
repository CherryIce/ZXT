//
//  ICEWatchImageView.h
//  ZXT
//
//  Created by 1 on 2019/5/28.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDImageCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface ICEWatchImageView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
