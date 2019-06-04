//
//  ICETableXibViewController.m
//  ZXT
//
//  Created by 1 on 2019/5/21.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICETableXibViewController.h"

@interface ICETableXibViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , retain) UITableView *tableView;

@property (nonatomic , retain) NSMutableArray * dataArray;

@end

static NSString * cellID = @"ICEXibTableViewCell";

@implementation ICETableXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configurationUI];
    [self afterGetData];
}

- (void) configurationUI {
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.size = CGSizeMake(60, 30);
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完毕" forState:UIControlStateSelected];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    editBtn.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.5];
    [editBtn addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
}

#pragma mark 点击编辑button
- (void)clickEditBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    //可以多个tableview同时进入编辑状态
    [self.tableView setEditing:sender.selected animated:YES];
}

#pragma mark 选择编辑模式，加入模式非常少用,默认是删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

#pragma mark 排序 当移动了某一行时候会调用
//编辑状态下。仅仅要实现这种方法，就能实现拖动排序
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //tableView判断哪个tableview在移动,取消其他tableview的编辑状态
    //sourceIndexPath 移动前
    //destinationIndexPath 移动后
    //数据需要调换
}

- (NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        //__weak __typeof(self) weakSelf = self;
        if (self.dataArray.count > 0) {
            UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                NSLog(@"x执行了删除操作");
                //[weakSelf postDelRoom:model.roomId];
            }];
            
            UITableViewRowAction *rowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"复制" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                NSLog(@"x执行了复制操作");
            }];
            rowAction.backgroundColor = [UIColor redColor];
            rowAction2.backgroundColor = [UIColor blueColor];
            NSArray *arr = @[rowAction,rowAction2];
            return arr;
        } else {
            return [NSArray array];
        }
    } else {
        return [NSArray array];
    }
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
        [self.view addSubview:_tableView];
        // 设置tabAnimated相关属性
        // 可以不进行手动初始化，将使用默认属性
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[ICEXibTableViewCell class] cellHeight:100];
        _tableView.tabAnimated.animatedColor = ColorRGB(93, 131, 237, 1);
        _tableView.tabAnimated.cancelGlobalCornerRadius = YES;
        _tableView.tabAnimated.animatedHeight = 7.0;
        _tableView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
            view.animation(1).down(3).height(12).toLongAnimation();
            view.animation(2).down(-5).height(12).toShortAnimation();
        };
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

//内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%@内存泄漏了....",self);
}

@end
