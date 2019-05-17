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

static NSString * cellID = @"ICECollectionViewCell";

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
    for (int i = 0; i < 10; i ++) {
        ICEModel * model = [[ICEModel alloc] init];
        [self.dataArray addObject:model];
    }
    [self.collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟数据
        [self.dataArray removeAllObjects];
        [self loadData];
    });
}

- (void) loadData {
    for (int i = 0; i < 10; i ++) {
        ICEModel * model = [[ICEModel alloc] init];
        model.cellH = 100;
        [self.dataArray addObject:model];
    }
    // 停止动画,并刷新数据
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return .1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ICECollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    ICEModel * model = self.dataArray[indexPath.row];
    if (model.cellH > 0) {
        cell.model = model;
    }
    return cell;
}

#pragma mark - Lazy Methods

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = true;
        [self.view addSubview:_collectionView];
        
        [_collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
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
