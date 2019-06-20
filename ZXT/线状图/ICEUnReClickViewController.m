//
//  ICEUnReClickViewController.m
//  ZXT
//
//  Created by 1 on 2019/6/12.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEUnReClickViewController.h"

#import "HWGuidePageManager.h"

#import "UIControl+ICEUnReClick.h"

@interface ICEUnReClickViewController ()

@property (nonatomic, retain) UIButton * selectBtn;

@end

@implementation ICEUnReClickViewController

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setFrame:CGRectMake(0, 0, 200, 50)];
        _selectBtn.center = self.view.center;
        [_selectBtn setTitle:@"测试下" forState:UIControlStateNormal];
        [_selectBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.cs_acceptEventInterval = 1;
    }
    return _selectBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.selectBtn];
}

- (void) buttonClick:(UIButton *) sender{
    [self showGuidePage];
}

- (void)showGuidePage
{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    
    CGRect startRact = [self.selectBtn convertRect:self.selectBtn.bounds toView:window];
    // 判断是否已显示过
    //    if (![[NSUserDefaults standardUserDefaults] boolForKey:HWGuidePageHomeKey]) {
    // 显示
    [[HWGuidePageManager shareManager] showGuidePageWithType:HWGuidePageTypeHome rect:startRact completion:^{
        [[HWGuidePageManager shareManager] showGuidePageWithType:HWGuidePageTypeMajor rect:startRact];
    }];
    //    }
    
    /**
     无限层操作
     [[HWGuidePageManager shareManager] showGuidePageWithType:HWGuidePageTypeHome rect:startRact completion:^{
     [[HWGuidePageManager shareManager] showGuidePageWithType:HWGuidePageTypeMajor rect:startRact completion:^{
     //code...
     }];
     }];
     **/
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
