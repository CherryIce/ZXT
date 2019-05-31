//
//  ICEImageView.h
//  ZXT
//
//  Created by 1 on 2019/5/29.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEImageView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic , retain) UIImageView * icon;

//默认是屏幕的宽和高
@property (assign, nonatomic) CGFloat imageNormalWidth; // 图片未缩放时宽度
@property (assign, nonatomic) CGFloat imageNormalHeight; // 图片未缩放时高度

//缩放方法，共外界调用
- (void)pictureZoomWithScale:(CGFloat)zoomScale;

@end

NS_ASSUME_NONNULL_END
