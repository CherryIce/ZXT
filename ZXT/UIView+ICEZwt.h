//
//  UIView+ICEZwt.h
//  ZXT
//
//  Created by 1 on 2019/5/20.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NoNetwork,//没有网络
    NoDataSorce//没有数据
} ZwtType;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ICEZwt)

/** 占位图 */
@property (nonatomic, strong, readonly) UIView *cq_placeholderView;

- (void)shoZWtWithType:(ZwtType)type descr:(nullable NSString *)descr reloadBlock:(void(^)(void))reloadBlock;

- (void) removeZwt;

@end

NS_ASSUME_NONNULL_END
