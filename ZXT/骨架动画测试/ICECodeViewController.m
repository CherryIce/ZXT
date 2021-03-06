//
//  ICECodeViewController.m
//  ZXT
//
//  Created by doman on 2019/5/9.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICECodeViewController.h"

#import "ICETableViewCell.h"

@interface ICECodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain) UITableView *tableView;

@property (nonatomic , retain) NSMutableArray * dataArray;

@property (nonatomic , assign) BOOL isFirst;

@property (nonatomic, assign) BOOL isNetwork;

@end

static NSString * CellID = @"ICETableViewCell";

@implementation ICECodeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _isFirst = true;
    _isNetwork = false;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self regsiterAnimated];
    [self afterGetData];
    
    [self.tableView bindHeadRefreshHandler:^{
        [self afterGetData];
    } themeColor:[UIColor blueColor] refreshStyle:KafkaRefreshStyleAnimatableArrow];
   // [self.tableView.headRefreshControl beginRefreshing];
}

#pragma mark - Target Methods

/**
 获取到数据后
 */
- (void)afterGetData {
    [self.tableView tab_startAnimation];   // 开启动画
    [self.dataArray removeAllObjects];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 停止动画,并刷新数据
        [self.tableView.headRefreshControl endRefreshing];
        [self.tableView tab_endAnimation];
        if (!self.isFirst) {
            if (!self.isNetwork){
                self.isNetwork = true;
                [self.view shoZWtWithType:NoNetwork descr:@"" reloadBlock:^{
                    [self.tableView.headRefreshControl beginRefreshing];
                }];
            }else{
                [self loadData];
            }
        }else{
            self.isFirst = false;
            [self.view shoZWtWithType:NoDataSorce descr:@"没有数据哈" reloadBlock:^{
                [self.tableView.headRefreshControl beginRefreshing];
            }];
        }
    });
}

- (void) loadData {
    // 模拟数据
    for (int i = 0; i < 10; i ++) {
        ICEModel * model = [[ICEModel alloc] init];
        model.icon = @"icon";
        model.titleName = [NSString stringWithFormat:@"%d.《肖申克的救赎》",i];
        model.titleDescr = [NSString stringWithFormat:@"%d.我回首前尘往事，犯下重罪的小笨蛋，我想跟他沟通让他明白，但我办不到，那个少年早就不见了，只剩下我垂老之躯",i];
        model.cellH = 70 + [ICETools getLabelHeightWithText:model.titleDescr width:kScreenWidth - 40 font:12];
        [self.dataArray addObject:model];
    }
    // 停止动画,并刷新数据
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count > 0) {
        ICEModel * m = self.dataArray[indexPath.row];
        return m.cellH;
    }
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ICETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (self.dataArray.count > 0) {
        ICEModel * m = self.dataArray[indexPath.row];
        cell.model = m;
    }
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
        [_tableView registerClass:[ICETableViewCell class] forCellReuseIdentifier:CellID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void) regsiterAnimated{
    // 设置tabAnimated相关属性
    // 可以不进行手动初始化，将使用默认属性
    self.tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[ICETableViewCell class] cellHeight:90];
    self.tableView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
        view.animation(1).down(3).height(12).toShortAnimation();
        view.animation(2).down(-5).height(12).toShortAnimation();
    };
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
