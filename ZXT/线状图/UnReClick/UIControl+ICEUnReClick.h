//
//  UIControl+ICEUnReClick.h
//  ZXT
//
//  Created by 1 on 2019/6/12.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (ICEUnReClick)

@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;

@end

NS_ASSUME_NONNULL_END
