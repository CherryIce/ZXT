//
//  ICEPageControlViewController.m
//  ZXT
//
//  Created by 1 on 2019/6/14.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEPageControlViewController.h"

#import "ICEScrollPageView.h"
#import "YXCalendarView.h"

#import "PGDatePickManager.h"

@interface ICEPageControlViewController ()<PGDatePickerDelegate>

@property (nonatomic , retain) ICEScrollPageView * v;

@property (nonatomic, strong) YXCalendarView *calendar;

@end

@implementation ICEPageControlViewController

- (ICEScrollPageView *)v{
    if (!_v) {
        _v = [[ICEScrollPageView alloc] initWithFrame:CGRectMake(0, kNavHegith+20, kScreenWidth, 200) dataSource:@""];
        //_v.center = self.view.center;
    }
    return _v;
}

- (YXCalendarView *)calendar{
    if (!_calendar) {
        _calendar = [[YXCalendarView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.v.frame) + 20, [UIScreen mainScreen].bounds.size.width, [YXCalendarView getMonthTotalHeight:[NSDate date]]) Date:[NSDate date]];
    }
    return _calendar;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.v.carousel controllerWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.v.carousel controllerWillDisAppear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.v];
    [self.view addSubview:self.calendar];
    
    //选择的日期
    self.calendar.sendSelectDate = ^(NSDate *selDate) {
        NSLog(@"%@",[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]);
    };
    
    __weak typeof(self) weakSelf = self;
    self.calendar.selectYearAndMonthCall = ^{
        PGDatePickManager *datePickManager = [ICEPageControlViewController initDatePickerWithDatePickerMode:PGDatePickerModeYearAndMonth delegate:weakSelf];
        [weakSelf presentViewController:datePickManager animated:false completion:nil];
    };
}

#pragma mark == 选择年月 PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:dateComponents];
    self.calendar.currentDate = date;
}

+ (PGDatePickManager *) initDatePickerWithDatePickerMode:(PGDatePickerMode)datePickerMode delegate:(id)delegate
{
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = delegate;
    datePicker.datePickerMode = datePickerMode;
    //设置半透明的背景颜色
    datePickManager.isShadeBackground = true;
    //设置头部的背景颜色
    datePickManager.headerViewBackgroundColor = [UIColor colorWithRed:252/255.00 green:251/255.00 blue:251/255.00 alpha:1];
    //设置线条的颜色
    datePicker.lineBackgroundColor = [UIColor groupTableViewBackgroundColor];
    //设置选中行的字体颜色
    datePicker.textColorOfSelectedRow = [UIColor darkTextColor];
    //设置未选中行的字体颜色
    datePicker.textColorOfOtherRow = [UIColor darkGrayColor];
    //设置取消按钮的字体颜色
    datePickManager.cancelButtonTextColor = [UIColor darkGrayColor];
    //设置取消按钮的字体大小
    datePickManager.cancelButtonFont = [UIFont boldSystemFontOfSize:16];
    
    //设置确定按钮的字体颜色
    datePickManager.confirmButtonTextColor = [UIColor orangeColor];
    //设置确定按钮的字体大小
    datePickManager.confirmButtonFont = [UIFont boldSystemFontOfSize:16];
    return datePickManager;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
