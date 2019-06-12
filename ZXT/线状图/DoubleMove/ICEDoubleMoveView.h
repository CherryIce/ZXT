//
//  ICEDoubleMoveView.h
//  ZXT
//
//  Created by 1 on 2019/6/11.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEDoubleMoveView : UIView

- (instancetype)initWithFrame:(CGRect)frame leftDataArr:(NSArray *)leftDataArr rightDataArr:(NSArray *)rightDataArr didSelectLeftRow:(NSInteger)leftRow rightRow:(NSInteger)rightRow;

- (void)show;

- (void)dismiss;

@property (nonatomic , copy) void (^confirmBtnCall)(NSInteger number,NSInteger row);

@property (nonatomic , copy) void (^cancelBtnCall)(void);

@end

NS_ASSUME_NONNULL_END
