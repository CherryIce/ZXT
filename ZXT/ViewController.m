//
//  ViewController.m
//  ZXT
//
//  Created by doman on 2019/5/8.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (nonatomic,strong) NSArray <NSString *> *titleArray;
@property (nonatomic,strong) NSArray <NSString *> *controllerClassArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    if ([CLLocationManager locationServicesEnabled]) {
        CLLocationManager * cl = [[CLLocationManager alloc] init];
        cl.delegate = self;
        cl.desiredAccuracy = kCLLocationAccuracyBest;
        cl.distanceFilter = 10;
        [cl requestWhenInUseAuthorization];
        [cl startUpdatingHeading];
    }else{
        //提醒打开定位功能
    }
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
    [self.tableView reloadData];
}

#pragma mark -- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //定位成功
    CLLocation * curr = [locations lastObject];
    CLGeocoder * geo = [[CLGeocoder alloc] init];
    [geo reverseGeocodeLocation:curr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark * placeMark in placemarks) {
            NSDictionary * address = placeMark.addressDictionary;
            NSLog(@"%@-%@-%@-%@",[address objectForKey:@"Country"],[address objectForKey:@"State"],[address objectForKey:@"City"],[address objectForKey:@"subLocality"]);
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //定位失败
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
             @"view骨架动画",
             @"图片处理",
             @"验证码",
             @"无关联的二级联动",
             @"按钮的防重点击",
             @"collection+pagecontrol",
             @"ICEPCViewController",
             @"collectionView交换cell",
             @"tableView交换cell",
             @"扫码",
             @"多section分区collectionView"];
}

- (NSArray *)controllerClassArray {
    return @[@"ICEZZTViewController",
             @"ICEZXTViewController",
             @"ICEBZTViewController",
             @"ICECodeViewController",
             @"ICETableXibViewController",
             @"ICECollectionViewController",
             @"ICEViewController",
             @"ICEImageViewController",
             @"ICEVfCodeViewController",
             @"ICEDoubleMoveViewController",
             @"ICEUnReClickViewController",
             @"ICEPageControlViewController",
             @"ICEPCViewController",
             @"ICECollectionMoveController",
             @"ICETableViewMoveController",
             @"ICEScanCodeViewController",
             @"ICEDHCollectionViewController"];
}

//内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存泄漏了....");
}

@end
