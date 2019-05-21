//
//  ICEViewController.m
//  ZXT
//
//  Created by doman on 2019/5/9.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEViewController.h"

@interface ICEViewController ()

@property (nonatomic, strong) ICETestView * codeView;

@property (nonatomic, strong) ICEXibView * xibView;

@end

@implementation ICEViewController

- (ICETestView *)codeView{
    if (!_codeView) {
        _codeView = [[ICETestView alloc] initWithFrame:CGRectMake(0, kNavHegith, kScreenWidth, 100)];
        _codeView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_codeView];
        _codeView.tabAnimated = TABViewAnimated.new;
        _codeView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeDrop;
        _codeView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
            view.animation(0).down(3).height(20).dropStayTime(0.4);
            view.animation(1).down(3).height(20).dropFromIndex(0);
            view.animation(2).down(3).height(12).dropFromIndex(1);
        };
    }
    return _codeView;
}

- (ICEXibView *)xibView {
    if (!_xibView) {
        _xibView = [[NSBundle mainBundle] loadNibNamed:@"ICEXibView" owner:self options:nil].firstObject;
        _xibView.frame = CGRectMake(0, 200, kScreenWidth, 300);
        [self.view addSubview:_xibView];
        
        _xibView.tabAnimated = TABViewAnimated.new;
        _xibView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
            view.animation(1).down(3).height(20).toShortAnimation();
            view.animation(2).down(3).height(12).toLongAnimation();
        };
    }
    return _xibView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void) loadData{
    
    /**
     经测试view可用骨架动画的是两种情况,纯代码和view关联的xib
     用cell编写的view视图不适用,这与框架监测的视图class有关.
     */
    [self.codeView tab_startAnimation];
    [self.xibView tab_startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.codeView tab_endAnimation];
        [self.xibView tab_endAnimation];
        [self refreshUI];
    });
}

- (void) refreshUI {
    ICEModel * model = [[ICEModel alloc] init];
    model.icon = @"icon";
    model.titleName = @"难受";
    model.titleDescr = @"人生就是一次次幸福的相聚，夹杂着一次次伤感的别离。 我不是在最好的时光遇见了你们，而是遇见了你们，我才有了这段最好的时光。";
    model.cellH = 50 + [ICETools getLabelHeightWithText:model.titleDescr width:kScreenWidth - 40 font:17];
    self.codeView.frame = CGRectMake(0, kNavHegith, kScreenWidth, model.cellH);
    self.codeView.model = model;
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
