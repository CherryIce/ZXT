//
//  ICEViewController.m
//  ZXT
//
//  Created by doman on 2019/5/9.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEViewController.h"

#import "ICETestView.h"
#import "ICEViewCell.h"

@interface ICEViewController ()

@property (nonatomic, strong) ICETestView * topView;

@property (nonatomic, strong) ICEViewCell * bottomView;

@end

@implementation ICEViewController

- (ICETestView *)topView{
    if (!_topView) {
        _topView = [[ICETestView alloc] initWithFrame:CGRectMake(0, kNavHegith, kScreenWidth, 100)];
        _topView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_topView];
        _topView.tabAnimated = TABViewAnimated.new;
        _topView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
            view.animation(0).down(3).height(20);
            view.animation(1).down(3).height(20).toShortAnimation();
            view.animation(2).down(3).height(12).toShortAnimation();
        };
    }
    return _topView;
}

- (ICEViewCell *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"ICEViewCell" owner:self options:nil].firstObject;
        [self.view addSubview:_bottomView];
        _bottomView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).topSpaceToView(self.topView, 10).heightIs(100);
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void) loadData{
    
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    [self.topView tab_startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.topView tab_endAnimation];
        [self refreshUI];
    });
}

- (void) refreshUI {
    ICEModel * model = [[ICEModel alloc] init];
    model.icon = @"icon";
    model.titleName = @"难受";
    model.titleDescr = @"人生就是一次次幸福的相聚，夹杂着一次次伤感的别离。 我不是在最好的时光遇见了你们，而是遇见了你们，我才有了这段最好的时光。";
    model.cellH = 50 + [ICETools getLabelHeightWithText:model.titleDescr width:kScreenWidth - 40 font:17];
    self.topView.frame = CGRectMake(0, kNavHegith, kScreenWidth, model.cellH);
    self.topView.model = model;
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
