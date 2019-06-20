//
//  ICEBillsOneCell.h
//  ZXT
//
//  Created by 1 on 2019/6/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEBillsOneCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *yingshouMoneyLab;//总应收
@property (weak, nonatomic) IBOutlet UIButton *chaKanLiushuiBtn;//查看流水

@property (weak, nonatomic) IBOutlet UILabel *lastMonthMoney;//上月实收
@property (weak, nonatomic) IBOutlet UIView *lastMonthView;//上月明细

@property (weak, nonatomic) IBOutlet UILabel *currentMonthMoney;//当月实收
@property (weak, nonatomic) IBOutlet UILabel *rateShow;//同比多少
@property (weak, nonatomic) IBOutlet UIImageView *down_raise;//上升还是下降
@property (weak, nonatomic) IBOutlet UIButton *currentMonthTips;//当月实收的一个展示
@property (weak, nonatomic) IBOutlet UIView *currentMonthView;//当月明细

@property (weak, nonatomic) IBOutlet UILabel *yushouMoney;//预收款
@property (weak, nonatomic) IBOutlet UIView *yushouView;//预收明细

@property (nonatomic , copy) void (^lastMonthCall)(UIView * view);
@property (nonatomic , copy) void (^currentMonthCall)(UIView * view);
@property (nonatomic , copy) void (^yushouCall)(UIView * view);

- (void) updateCellWithObj:(id)obj;

@end

NS_ASSUME_NONNULL_END
