//
//  YXCalendarView.m
//  Calendar
//
//  Created by Vergil on 2017/7/6.
//  Copyright © 2017年 Vergil. All rights reserved.
//

#import "YXCalendarView.h"

#import "MMButton.h"

static CGFloat const yearMonthH = 40;   //年月高度
static CGFloat const weeksH = 30;       //周高度
#define ViewW self.frame.size.width     //当前视图宽度
#define ViewH self.frame.size.height    //当前视图高度

@interface YXCalendarView ()

@property (nonatomic , retain) MMButton * selectYearMonthBtn;//选择年月按钮

@property (nonatomic, strong) UIScrollView *scrollV;    //scrollview
@property (nonatomic, assign) CalendarType type;        //选择类型
@property (nonatomic, strong) NSDate *selectDate;       //选中日期
@property (nonatomic, strong) NSDate *tmpCurrentDate;   //记录上下滑动日期

@property (nonatomic, strong) YXMonthView *leftView;    //左侧日历
@property (nonatomic, strong) YXMonthView *middleView;  //中间日历
@property (nonatomic, strong) YXMonthView *rightView;   //右侧日历

@end

@implementation YXCalendarView

- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _currentDate = date;
        _selectDate = date;
        [self settingViews];
    }
    return self;
}

- (void)dealloc
{
    [_scrollV removeObserver:self forKeyPath:@"contentOffset"];
}

//MARK: - otherMethod
+ (CGFloat)getMonthTotalHeight:(NSDate *)date{
    NSInteger rows = [[YXDateHelpObject manager] getRows:date];
    return yearMonthH + weeksH + rows * dayCellH;
}

- (void)settingViews {
    [self settingHeadLabel];
    [self settingScrollView];
    [self addObserver];
}

- (void)settingHeadLabel {
    
    UIView * headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewW, yearMonthH)];
    headV.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:headV];

    NSArray * labTitle = @[@"逾期/待收",@"当天",@"到期"];
    NSArray * images = @[@"red_point",@"orange_point",@"blue_point"];
    for (int j = 0; j < labTitle.count; j++) {
        MMButton * button = [MMButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        if (j == 0) {
            [button setFrame:CGRectMake(15, 10, 63, 20)];
        }else{
            [button setFrame:CGRectMake(78+20*j+40*(j-1), 10, 40, 20)];
        }
        [button setTitle:labTitle[j] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkTextColor]  forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[j]] forState:UIControlStateNormal];
        button.spaceBetweenTitleAndImage = 5;
        [headV addSubview:button];
    }
    
    _selectYearMonthBtn = [MMButton buttonWithType:UIButtonTypeCustom];
    [_selectYearMonthBtn  setFrame:CGRectMake(headV.frame.size.width - 100, 5, 85, 30)];
    [_selectYearMonthBtn setTitleColor:[UIColor darkTextColor]  forState:UIControlStateNormal];
    [_selectYearMonthBtn setImage:[UIImage imageNamed:@"red_point"] forState:UIControlStateNormal];
    _selectYearMonthBtn.imageAlignment = MMImageAlignmentRight;
    _selectYearMonthBtn.spaceBetweenTitleAndImage = 8;
    [_selectYearMonthBtn setAttributedTitle:[self getDateString] forState:UIControlStateNormal];
    [_selectYearMonthBtn addTarget:self action:@selector(selectYearAndMonthRefresh:) forControlEvents:UIControlEventTouchUpInside];
    [headV addSubview:self.selectYearMonthBtn];
    
    NSArray *weekdays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekdayW = ViewW/7;
    for (int i = 0; i < 7; i++) {
        UILabel *weekL = [[UILabel alloc] initWithFrame:CGRectMake(i*weekdayW, yearMonthH, weekdayW, weeksH)];
        weekL.textAlignment = NSTextAlignmentCenter;
        weekL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
        weekL.text = weekdays[i];
        if (i == 0 || i == 6) {
            weekL.textColor = [UIColor redColor];
        }
        [self addSubview:weekL];
    }
}

- (void)settingScrollView {
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yearMonthH + weeksH, ViewW, ViewH - yearMonthH - weeksH)];
    _scrollV.contentSize = CGSizeMake(ViewW * 3, 0);
    _scrollV.pagingEnabled = YES;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollV];
    
    __weak typeof(self) weakSelf = self;
    CGFloat height = 6 * dayCellH;
    _leftView = [[YXMonthView alloc] initWithFrame:CGRectMake(0, 0, ViewW, height) Date:[[YXDateHelpObject manager] getPreviousMonth:_currentDate]];
    _leftView.selectDate = _selectDate;
    
    _middleView = [[YXMonthView alloc] initWithFrame:CGRectMake(ViewW, 0, ViewW, height) Date:_currentDate];
    _middleView.selectDate = _selectDate;
    _middleView.sendSelectDate = ^(NSDate *selDate) {
        weakSelf.selectDate = selDate;
        if (weakSelf.sendSelectDate) {
            weakSelf.sendSelectDate(selDate);
        }
        [weakSelf setData];
    };
    
    _rightView = [[YXMonthView alloc] initWithFrame:CGRectMake(ViewW * 2, 0, ViewW, height) Date:[[YXDateHelpObject manager] getNextMonth:_currentDate]];
    _rightView.selectDate = _selectDate;
    
    [_scrollV addSubview:_leftView];
    [_scrollV addSubview:_middleView];
    [_scrollV addSubview:_rightView];
    
    [self scrollToCenter];
}

- (void)setData {
    _middleView.currentDate = _currentDate;
    _leftView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
    _rightView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
    _middleView.selectDate = _selectDate;
    _leftView.selectDate = _selectDate;
    _rightView.selectDate = _selectDate;
}

//MARK: - kvo
- (void)addObserver {
    [_scrollV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self monitorScroll];
    }
    
}

- (void)monitorScroll {
    
    if (_scrollV.contentOffset.x > 2*ViewW -1) {
        
        _leftView.currentDate = _currentDate;
        _middleView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
        _currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
        _rightView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
        
        [_selectYearMonthBtn setAttributedTitle:[self getDateString] forState:UIControlStateNormal];
        
        _rightView.selectDate = _selectDate;
        _leftView.selectDate = _selectDate;
        _middleView.selectDate = _selectDate;
        
        [self scrollToCenter];
        
    } else if (_scrollV.contentOffset.x < 1) {
        
        _rightView.currentDate = _currentDate;
        //右滑,上个月
        _middleView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
        _currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
        _leftView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
        
        [_selectYearMonthBtn setAttributedTitle:[self getDateString] forState:UIControlStateNormal];
        
        _rightView.selectDate = _selectDate;
        _leftView.selectDate = _selectDate;
        _middleView.selectDate = _selectDate;
        
        [self scrollToCenter];
    }
    
}

#pragma mark ---左右刷新时---
//MARK: - scrollViewMethod
- (void)scrollToCenter {
    _scrollV.contentOffset = CGPointMake(ViewW, 0);
    
    //_currentDate
    //可以在这边进行网络请求获取事件日期数组等,记得取消上个未完成的网络请求
    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i < 10; i++) {
//        NSString *dateStr = [NSString stringWithFormat:@"%@-%d",[[YXDateHelpObject manager] getStrFromDateFormat:@"MM" Date:_currentDate],1 + arc4random()%28];
//        [array addObject:dateStr];
//    }
    
    _middleView.eventArray = array;
}

#pragma mark ---- 选择年月刷新
- (void) selectYearAndMonthRefresh:(UIButton *) sender
{
//弹出年月选择器,选完后将选中的NSDate替换掉_currentDate,然后更新按钮显示内容,走scrollToCenter请求刷新collection内容
    if (_selectYearAndMonthCall) {
        _selectYearAndMonthCall();
    }
}

- (NSMutableAttributedString *) getDateString {
    NSString * string = [[YXDateHelpObject manager] getStrFromDateFormat:@"MM/yyyy" Date:_currentDate];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    NSUInteger length = [string length];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:15] range:NSMakeRange(0, length)];//设置所有的字体
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size: 24] range:NSMakeRange(0, 2)];
    return attr;
}

#pragma mark --- x日期
- (void)setCurrentDate:(NSDate *)currentDate{
    _currentDate = currentDate;
    [_selectYearMonthBtn setAttributedTitle:[self getDateString] forState:UIControlStateNormal];
    [self setData];
    //网络请求后再 这就是reloadata
    [self scrollToCenter];
}

@end
