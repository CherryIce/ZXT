//
//  ICEDoubleMoveView.m
//  ZXT
//
//  Created by 1 on 2019/6/11.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEDoubleMoveView.h"

#import "PGPickerView.h"

@interface ICEDoubleMoveView()<PGPickerViewDelegate, PGPickerViewDataSource>

@property(nonatomic,strong) PGPickerView *picker;

@property (nonatomic,retain) UIView * bgView;

@property (nonatomic,retain) NSArray * leftData;

@property (nonatomic,retain) NSArray * rightData;

@property(nonatomic,assign) NSInteger leftIndex;

@property(nonatomic,assign) NSInteger rightIndex;

@property (nonatomic, retain) UIButton * sureBtn;

@property (nonatomic, retain) UIButton * cancelBtn;

@end

@implementation ICEDoubleMoveView

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setFrame:CGRectMake(kScreenWidth - 70, 0, 70, 40)];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setFrame:CGRectMake(0, 0, 70, 40)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (PGPickerView *)picker{
    if (!_picker) {
        _picker = [[PGPickerView alloc] initWithFrame:CGRectMake(0, 40, self.bgView.frame.size.width, self.bgView.frame.size.height - 40)];
        _picker.backgroundColor = [UIColor whiteColor];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.type = PGPickerViewLineTypeline;
        _picker.isHiddenMiddleText = false;
        _picker.rowHeight = 50;
        _picker.lineBackgroundColor = [UIColor colorWithRed:235/255.00 green:235/255.00 blue:235/255.00 alpha:1];
        //设置线条的颜色
        _picker.lineBackgroundColor = [UIColor redColor];
        //设置选中行的字体颜色
        _picker.textColorOfSelectedRow = [UIColor blueColor];
        //设置未选中行的字体颜色
        _picker.textColorOfOtherRow = [UIColor blackColor];
        [self.bgView addSubview:_picker];
    }
    return _picker;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 290, self.frame.size.width, 290)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (instancetype)initWithFrame:(CGRect)frame leftDataArr:(NSArray *)leftDataArr rightDataArr:(NSArray *)rightDataArr didSelectLeftRow:(NSInteger)leftRow rightRow:(NSInteger)rightRow{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.sureBtn];
         [self.bgView addSubview:self.cancelBtn];
        _leftData = leftDataArr;
        _rightData = rightDataArr;
        _leftIndex = leftRow;
        _rightIndex = rightRow;
        [self.picker selectRow:leftRow inComponent:0 animated:true];
        [self.picker selectRow:rightRow inComponent:1 animated:true];
    }
    return self;
}

#pragma UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(PGPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(PGPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _leftData.count;
    }
    return _rightData.count;
}
#pragma UIPickerViewDelegate
- (nullable NSString *)pickerView:(PGPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return _leftData[row];
    }
    return _rightData[row];
}

- (void)pickerView:(PGPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _leftIndex = row;
    }else{
        _rightIndex = row;
    }
    //防止越界
    if (_leftIndex>=_leftData.count) {
        [self.picker selectRow:_leftIndex-1 inComponent:0 animated:true];
    }
    NSLog(@"row = %ld component = %ld", row, component);
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    self.bgView.transform = CGAffineTransformScale(self.bgView.transform,1.3,1.6);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        self.bgView.transform = CGAffineTransformIdentity;
        self.bgView.alpha = 1.0;
    } completion:nil];
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)cancelClick
{
    [self dismiss];
    if (_cancelBtnCall) {
        _cancelBtnCall();
    }
}

- (void)confirmClick
{
    [self dismiss];
    NSLog(@"%zd--%zd",_leftIndex,_rightIndex);
    if (_confirmBtnCall) {
        _confirmBtnCall(_leftIndex,_rightIndex);
    }
}

@end
