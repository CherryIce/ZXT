//
//  ICEXibViewController.m
//  ZXT
//
//  Created by doman on 2019/5/9.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEXibViewController.h"

@interface ICEXibViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain) UITableView *tableView;

@property (nonatomic , retain) NSMutableArray * dataArray;

@end

static NSString * cellID = @"ICEXibTableViewCell";

@implementation ICEXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self afterGetData];
}

#pragma mark - Target Methods
/**
 获取到数据后
 */
- (void)afterGetData {
    [self.tableView tab_startAnimation];   // 开启动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟数据
        for (int i = 0; i < 10; i ++) {
            [self.dataArray addObject:@(i)];
        }
        // 停止动画,并刷新数据
        [self.tableView tab_endAnimation];
    });
}

#pragma mark - UITableViewDelegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ICEXibTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

#pragma mark - Lazy Methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
        // 设置tabAnimated相关属性
        // 可以不进行手动初始化，将使用默认属性
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[ICEXibTableViewCell class] cellHeight:100];
        _tableView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
            view.animation(1).down(3).height(12).toShortAnimation();
            view.animation(2).down(-5).height(12).toShortAnimation();
        };
//        _tableView.tabAnimated.cancelGlobalCornerRadius = YES;
//        _tableView.tabAnimated.animatedHeight = 14.f;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc {
    NSLog(@"==========  dealloc  ==========");
}

@end

