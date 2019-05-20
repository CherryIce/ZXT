//
//  ICELoadingView.h
//  ZXT
//
//  Created by 1 on 2019/5/20.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICELoadingView : UIView

+ (ICELoadingView *) shareInstance;

+ (void) showInView:(UIView *)view;

+ (void) disMissView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
