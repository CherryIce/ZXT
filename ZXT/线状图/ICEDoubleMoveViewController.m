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
}


- (void) buttonClick:(UIButton *) sender{
    ICEDoubleMoveView * v = [[ICEDoubleMoveView alloc] initWithFrame:CGRectZero leftDataArr:@[@"1",@"2",@"3",@"4",@"5"] rightDataArr:@[@"月",@"年"] didSelectLeftRow:2 rightRow:1];
    [v show];
}

@end
