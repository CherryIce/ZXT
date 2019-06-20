//
//  ICEBillsTwoCell.h
//  ZXT
//
//  Created by 1 on 2019/6/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEBillsTwoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *totalRooms;

@property (weak, nonatomic) IBOutlet UIButton *searchMXBtn;

@property (weak, nonatomic) IBOutlet UILabel *kongzhiLabel;

@property (weak, nonatomic) IBOutlet UILabel *yishouLabel;
@property (weak, nonatomic) IBOutlet UIButton *yishouBtn;//点击事件跳出已收定义tips
@property (weak, nonatomic) IBOutlet UIView *yishouView;//点击跳已收明细

@property (weak, nonatomic) IBOutlet UILabel *weishouLabel;
@property (weak, nonatomic) IBOutlet UIButton *weishouBtn;//点击事件跳出未收定义tips
@property (weak, nonatomic) IBOutlet UIView *weishouView;//点击跳未收明细

@property (weak, nonatomic) IBOutlet UILabel *weichuLabel;


@property (nonatomic , copy) void (^yShouViewCall)(UIView * view);
@property (nonatomic , copy) void (^wShouViewCall)(UIView * view);

- (void) updateCellWithObj:(id)obj;

@end

NS_ASSUME_NONNULL_END
