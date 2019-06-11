//
//  ICEVfCodeViewController.m
//  ZXT
//
//  Created by 1 on 2019/6/11.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEVfCodeViewController.h"

@interface ICEVfCodeViewController ()

@end

@implementation ICEVfCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CRBoxInputView * secretCode = [self generateBoxInputView_SecretCode];
    [self.view addSubview:secretCode];
    
    __weak typeof(secretCode) weakSecretCode = secretCode;
    secretCode.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        if (isFinished) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"安全密码" message:text preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSecretCode setUserInteractionEnabled:false];
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:true];
            }];
            
            [alert addAction:cancel];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:false completion:nil];
        }
    };
    
    CRBoxInputView * ssCode = [self generateBoxInputView_SSCode];
    [self.view addSubview:ssCode];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(ssCode.frame), CGRectGetMaxY(ssCode.frame) + 2, ssCode.frame.size.width, 2)];
    line.backgroundColor = [UIColor redColor];
    [self.view addSubview:line];
    
    __weak typeof(ssCode) weakSSCode = ssCode;
    ssCode.textDidChangeblock = ^(NSString *text, BOOL isFinished) {
        if (isFinished) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"短信验证码" message:text preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSSCode setUserInteractionEnabled:false];
            }];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:true];
            }];
            
            [alert addAction:cancel];
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:false completion:nil];
        }
    };
}

#pragma mark - Normal
- (CRBoxInputView *)generateBoxInputView_SecretCode
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellFont = [UIFont boldSystemFontOfSize:24];
    cellProperty.cellTextColor = [UIColor darkTextColor];
    cellProperty.securitySymbol = @"●";
    
    CRBoxInputView *_boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(30, kScreenHeight/2 - 60, kScreenWidth - 60, 50)];
    [_boxInputView loadAndPrepareView];
    _boxInputView.ifNeedSecurity = YES;
    _boxInputView.customCellProperty = cellProperty;
    _boxInputView.codeLength = 6;
    
    [_boxInputView loadAndPrepareViewWithBeginEdit:NO];
    return _boxInputView;
}

- (CRBoxInputView *)generateBoxInputView_SSCode
{
    CRBoxInputCellProperty *cellProperty = [CRBoxInputCellProperty new];
    cellProperty.cellCursorHeight = (kScreenWidth/2 - 30)/12;
    cellProperty.borderWidth = 0;
    cellProperty.cornerRadius = 0;
    
    CRBoxInputView *_boxInputView = [[CRBoxInputView alloc] initWithFrame:CGRectMake(30, kScreenHeight/2 + 10,kScreenWidth/2 - 30, (kScreenWidth/2 - 30)/6)];
    [_boxInputView loadAndPrepareView];
    _boxInputView.codeLength = 6;
    _boxInputView.customCellProperty = cellProperty;
    _boxInputView.boxFlowLayout.itemSize = CGSizeMake((kScreenWidth/2 - 30)/6, (kScreenWidth/2 - 30)/6);
    
    if (@available(iOS 12.0, *)) {
        _boxInputView.textContentType = UITextContentTypeOneTimeCode;
    }else if (@available(iOS 10.0, *)) {
        _boxInputView.textContentType = @"one-time-code";
    }
    [_boxInputView loadAndPrepareViewWithBeginEdit:NO];
    return _boxInputView;
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
