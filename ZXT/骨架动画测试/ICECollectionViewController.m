//
//  ICECollectionViewController.m
//  ZXT
//
//  Created by doman on 2019/5/9.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICECollectionViewController.h"

@interface ICECollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString * cellID = @"ICECodeCollectionViewCell";

@implementation ICECollectionViewController

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
    [self.collectionView tab_startAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟数据
        [self loadData];
    });
}

- (void) loadData {
    for (int i = 0; i < 10; i ++) {
        ICEModel * model = [[ICEModel alloc] init];
        model.titleName = @"xxx";
        model.titleDescr = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
        model.cellH = 100;
        [self.dataArray addObject:model];
    }
    [self.collectionView tab_endAnimation];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake (5, 5, 5, 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ICECodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    ICEModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Lazy Methods

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenWidth - 10, 100);
     
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = true;
        [self.view addSubview:_collectionView];
        
        // 初始化并设置动画相关属性
        _collectionView.tabAnimated =
        [TABCollectionAnimated animatedWithCellClass:[ICECodeCollectionViewCell class]
                                            cellSize:CGSizeMake(kScreenWidth - 10, 100)];
        _collectionView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeDrop;
        _collectionView.tabAnimated.animatedHeight = 7.0;
        _collectionView.tabAnimated.cancelGlobalCornerRadius = YES;
        _collectionView.tabAnimated.categoryBlock = ^(UIView * _Nonnull view) {
        };
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    NSLog(@"========= delloc =========");
}

@end
