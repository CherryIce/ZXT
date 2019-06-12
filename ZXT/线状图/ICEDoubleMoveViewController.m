//
//  ICEDoubleMoveViewController.m
//  ZXT
//
//  Created by 1 on 2019/6/11.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEDoubleMoveViewController.h"

#import "ICEDoubleMoveView.h"

@interface ICEDoubleMoveViewController ()

@property (nonatomic, retain) UIButton * selectBtn;

@property (nonatomic, copy) NSString * numberStr;

@property (nonatomic, copy) NSString * dateStr;

@end

@implementation ICEDoubleMoveViewController

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setFrame:CGRectMake(30, kScreenWidth/2 - 25, kScreenWidth - 60, 50)];
        [_selectBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_selectBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.selectBtn];
    
    _numberStr = @"2";
    _dateStr = @"1";
}


- (void) buttonClick:(UIButton *) sender{
    
    NSArray * numberArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    NSArray * dateArr = @[@"月",@"年"];
    ICEDoubleMoveView * v = [[ICEDoubleMoveView alloc] initWithFrame:CGRectZero leftDataArr:numberArr rightDataArr:dateArr didSelectLeftRow:[_numberStr integerValue] rightRow:[_dateStr integerValue]];
    [v show];
    v.titleStr = @"选择租期";
    
    __weak typeof(self) weakSelf = self;
    v.confirmBtnCall = ^(NSInteger number, NSInteger row) {
        weakSelf.numberStr = [NSString stringWithFormat:@"%zd",number];
        weakSelf.dateStr = [NSString stringWithFormat:@"%zd",row];
        [weakSelf.selectBtn setTitle:[NSString stringWithFormat:@"%@%@",numberArr[number],dateArr[row]] forState:UIControlStateNormal];
    };
}

@end
