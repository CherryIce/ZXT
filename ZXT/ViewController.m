//
//  ViewController.m
//  ZXT
//
//  Created by doman on 2019/5/8.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray <NSString *> *titleArray;
@property (nonatomic,strong) NSArray <NSString *> *controllerClassArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"主页面";
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.controllerClassArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        vc.title = self.titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - Initize Methods

/**
 initialize view
 初始化视图
 */
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
     [self.tableView tab_startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView tab_endAnimation];
    });
}

#pragma mark - Lazy Methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[UITableViewCell class] cellHeight:50];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)titleArray {
    //骨架动画详情请去看:https://github.com/tigerAndBull/TABAnimated
    //建议用代码,别用pod,因为感觉作者更新之后容易忘记提交到pod
    return @[@"柱状图",
             @"折线图",
             @"饼状图",
             @"纯代码表格骨架动画",
             @"xib表格骨架动画",
             @"collection表格骨架动画",
             @"view骨架动画"];
}

- (NSArray *)controllerClassArray {
    return @[@"ICEZZTViewController",
             @"ICEZXTViewController",
             @"ICEBZTViewController",
             @"ICECodeViewController",
             @"ICEXibViewController",
             @"ICECollectionViewController",
             @"ICEViewController"];
}


@end
