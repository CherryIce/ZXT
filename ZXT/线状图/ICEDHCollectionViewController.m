//
//  ICEDHCollectionViewController.m
//  ZXT
//
//  Created by 1 on 2020/1/9.
//  Copyright © 2020 Free world co., LTD. All rights reserved.
//

#import "ICEDHCollectionViewController.h"

#import "KJBannerHeader.h"

@interface ICEDHCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KJBannerViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ICEDHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    CGFloat bannerW = self.collectionView.frame.size.width - 2*16;
    CGFloat bannerH = bannerW * 179/343;
    // 上面 headView 的高度
    CGFloat headViewH = bannerH + 20;
    // 将 headerView 的 X 值设置为负值，为 headerView 的高度
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, -headViewH, self.collectionView.frame.size.width, headViewH)];
     
    
    KJBannerView * banner = [[KJBannerView alloc]initWithFrame:CGRectMake(16, 10, bannerW, bannerH)];
    banner.delegate = self;
    banner.pageControl.pageType = PageControlStyleSizeDot;
    banner.imageType = KJBannerViewImageTypeMix;
    banner.imageDatas = @[@"imagePlaceholder",@"http://photos.tuchong.com/285606/f/4374153.jpg"];
    [headView addSubview:banner];
    
    [self.collectionView addSubview:headView];
    // 内缩 collectionView 的显示内容
    self.collectionView.contentInset = UIEdgeInsetsMake(headViewH, 0, 0, 0);
    
    [self.collectionView reloadData];
}

#pragma mark 定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

#pragma mark 定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    
    if (indexPath.section %2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

#pragma mark 头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth-20, 30)];
    label.text = @"section头";
    label.textColor = [UIColor darkTextColor];
    [headerView addSubview:label];
    return headerView;
}
#pragma mark UICollectionView被选中时调用的方法

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择%ld",indexPath.item);
}

#pragma mark --KJBannerViewDelegate
/** 点击图片回调 */
- (void)kj_BannerView:(KJBannerView *)banner SelectIndex:(NSInteger)index {
    NSLog(@"index = %ld",(long)index);
}

/** 滚动时候回调 是否隐藏自带的PageControl */
- (BOOL)kj_BannerView:(KJBannerView *)banner CurrentIndex:(NSInteger)index {
    return false;
}

#pragma mark - Lazy Methods

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenWidth - 50)/5, 100);
        //定义每个UICollectionView 横向的间距
        layout.minimumLineSpacing = 10;
        //定义每个UICollectionView 纵向的间距
        layout.minimumInteritemSpacing = 10;
        //定义每个UICollectionView 的边距距
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//上左下右
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 30);
     
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = true;
        [self.view addSubview:_collectionView];
        
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        //自适应大小
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
