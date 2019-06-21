//
//  ICEPageControl.h
//  ZXT
//
//  Created by 1 on 2019/6/18.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEPageControl : UIView

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, assign) NSInteger pageNumbers;

- (instancetype)initWithFrame:(CGRect)frame pageNumbers:(NSInteger)pageNumbers;

@end

NS_ASSUME_NONNULL_END
