//
//  YXDayCell.m
//  Calendar
//
//  Created by Vergil on 2017/7/6.
//  Copyright © 2017年 Vergil. All rights reserved.
//

#import "YXDayCell.h"

@interface YXDayCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *dayL;     //日期
@property (weak, nonatomic) IBOutlet UILabel *blueLab;
@property (weak, nonatomic) IBOutlet UILabel *redLab;

@end

@implementation YXDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _dayL.layer.cornerRadius = 15;
    _bgView.layer.cornerRadius = 22;
    _blueLab.layer.cornerRadius = 8;
    _redLab.layer.cornerRadius = 8;
    _blueLab.clipsToBounds = true;
    _redLab.clipsToBounds = true;
}

- (void) updateWithObj:(id) obj{
    if ([[YXDateHelpObject manager] checkSameMonth:obj AnotherMonth:_currentDate]) {
        [self showDateFunctionWithObj:obj];
    } else {
        [self showSpaceFunction];
    }
}


//MARK: - otherMethod
- (void)showSpaceFunction {
    self.userInteractionEnabled = NO;
    _bgView.backgroundColor = [UIColor clearColor];
    _dayL.text = @"";
    _dayL.backgroundColor = [UIColor clearColor];
    _blueLab.hidden = true;
    _redLab.hidden = true;
}

- (void)showDateFunctionWithObj:(id)obj {
    
    self.userInteractionEnabled = YES;
    
    _dayL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"d" Date:obj];
    
    NSInteger index = [[YXDateHelpObject manager] getNumberInWeek:obj];
    if (index == 1 || index == 7) {
        _dayL.textColor = [UIColor redColor];
    }else{
        _dayL.textColor = [UIColor darkTextColor];
    }
    
    if ([[YXDateHelpObject manager] isSameDate:obj AnotherDate:[NSDate date]]) {
        _dayL.backgroundColor = [UIColor colorWithRed:233/255.0 green:206/255.0 blue:61/255.0 alpha:1.0];
        _bgView.backgroundColor = [UIColor colorWithRed:249/255.0 green:243/255.0 blue:196/255.0 alpha:1.0];
        _blueLab.hidden = true;
        _redLab.hidden = true;
    } else {
        _dayL.backgroundColor = [UIColor clearColor];
        _bgView.backgroundColor = [UIColor clearColor];
        _blueLab.hidden = false;
        _redLab.hidden = false;
    }
    
    //选中状态颜色的改变,不做
//    if (_selectDate) {
//        if ([[YXDateHelpObject manager] isSameDate:obj AnotherDate:_selectDate]) {
//
//        } else {
//            _dayL.backgroundColor = [UIColor clearColor];
//            _dayL.textColor = [UIColor blackColor];
//
//        }
//
//    }
}

@end
