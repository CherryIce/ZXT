//
//  ICEPageScollerView.m
//  ZXT
//
//  Created by 1 on 2019/6/18.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEPageScollerView.h"

#import "WBPopOverView.h"

#import "ICEPageControl.h"
#import "ICEFlowLayout.h"
#import "ICEBillsOneCell.h"
#import "ICEBillsTwoCell.h"
#import "ICETestCollectionViewCell.h"

#define count 3

#define Item_Width [UIScreen mainScreen].bounds.size.width - 40

@interface ICEPageScollerView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) ICEPageControl * pageControl;

@property (nonatomic,strong) UICollectionView * collectionView;

@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@end

static NSString * cellID1 = @"ICEBillsOneCell";
static NSString * cellID2 = @"ICEBillsTwoCell";
static NSString * cellID3 = @"ICETestCollectionViewCell";

@implementation ICEPageScollerView

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        ICEFlowLayout *layout = [[ICEFlowLayout alloc] init];
        //设置是否需要分页
        [layout setPagingEnabled:YES];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (ICEPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[ICEPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 150, CGRectGetMaxY(self.collectionView.frame) + 5, 300, 20) pageNumbers:2];
        _pageControl.currentPage = 0;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.collectionView registerNib:[UINib nibWithNibName:cellID1 bundle:nil] forCellWithReuseIdentifier:cellID1];
        [self.collectionView registerNib:[UINib nibWithNibName:cellID2 bundle:nil] forCellWithReuseIdentifier:cellID2];
        [self.collectionView registerNib:[UINib nibWithNibName:cellID3 bundle:nil] forCellWithReuseIdentifier:cellID3];
    }
    return self;
}


#pragma mark cell的数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark cell的视图
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ICEBillsOneCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID1 forIndexPath:indexPath];
        //更新数据写一个方法 [cell updateCell:obj];
        [cell.currentMonthTips addTarget:self action:@selector(currentMonthTipsClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.chaKanLiushuiBtn addTarget:self action:@selector(chaKanLiushuiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.lastMonthCall = ^(UIView * _Nonnull view) {
            [self lastMonthClick:view];
        };
        cell.currentMonthCall = ^(UIView * _Nonnull view) {
            [self currentMonthClick:view];
        };
        cell.yushouCall = ^(UIView * _Nonnull view) {
            [self yujiaoMingXiClick:view];
        };
        
        return cell;
    }
    if (indexPath.row == 1) {
        ICEBillsTwoCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID2 forIndexPath:indexPath];
        cell.yShouViewCall = ^(UIView * _Nonnull view) {
            [self yShouViewClick:view];
        };
        cell.wShouViewCall = ^(UIView * _Nonnull view) {
            [self wShouViewClick:view];
        };
        [cell.searchMXBtn  addTarget:self action:@selector(searchDetailsClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.yishouBtn  addTarget:self action:@selector(tipsClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.weishouBtn  addTarget:self action:@selector(tipsClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    ICETestCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellID3 forIndexPath:indexPath];
    return cell;
}

#pragma mark cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Item_Width, self.frame.size.height - 30);
}

#pragma mark cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击%ld",indexPath.row);
    
}

#pragma 停止滑动监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x+Item_Width, 0.5*scrollView.bounds.size.height)];
    
    for (UIView * v in self.collectionView.subviews) {
        v.layer.cornerRadius = 5;
    }
    
    if (!indexPath || self.currentIndexPath == indexPath) {
        return;
    }
    self.currentIndexPath = indexPath;
    
    self.pageControl.currentPage = indexPath.row;
}

#pragma mark ----- cell1点击事件 -----

//查看流水
- (void) chaKanLiushuiBtnClick:(UIButton *) sender
{
    
}

//上月实收点击事件 需要回掉到主界面处理
- (void) lastMonthClick:(UIView *)month
{
    NSLog(@"1");
}

//当月视图点击 需要回掉到主界面处理
- (void) currentMonthClick:(UIView *)month
{
    NSLog(@"2");
}

//当月按钮点击
- (void) currentMonthTipsClick: (UIButton *) button
{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [button convertRect:button.bounds toView:window];
    
    CGPoint point=CGPointMake(rect.origin.x + button.frame.size.width/2,rect.origin.y + button.frame.size.height);//箭头点的位置
    [self popviewWithPoint:point height:50 direction:WBArrowDirectionUp2 text:@"已收：指全部应收款项已收齐的房间。 "];
}

//预交明细点击 需要回掉到主界面处理
- (void) yujiaoMingXiClick:(UIView *)yujiaoView
{
    NSLog(@"3");
}

#pragma mark --- cell2点击事件 ---

//查询明细
- (void) searchDetailsClick:(UIButton *) sender
{
    
}

- (void) tipsClick:(UIButton *) button
{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [button convertRect:button.bounds toView:window];
    
    CGPoint point=CGPointMake(rect.origin.x + button.frame.size.width/2,rect.origin.y + button.frame.size.height);//箭头点的位置
    switch (button.tag) {
        case 1000:
        {
            [self popviewWithPoint:point height:50 direction:WBArrowDirectionUp2 text:@"已收：指全部应收款项已收齐的房间。 "];
        }
            break;
        case 2000:
        {
            [self popviewWithPoint:point height:70 direction:WBArrowDirectionUp3 text:@"未收：包含所有未交租房间，以及已部分交租但尚未完全结清的房间。 "];
        }
            break;
        default:
            break;
    }
}

//预交明细点击 需要回掉到主界面处理
- (void) yShouViewClick:(UIView *)yujiaoView
{
    NSLog(@"4");
}

//预交明细点击 需要回掉到主界面处理
- (void) wShouViewClick:(UIView *)yujiaoView
{
    NSLog(@"5");
}

//弹出视图
- (void) popviewWithPoint:(CGPoint)point height:(float)height direction:(WBArrowDirection)direction text:(NSString *)text{
    WBPopOverView * view = [[WBPopOverView alloc]initWithOrigin:point Width:200 Height:height Direction:direction];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 180, height - 10)];
    lable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    lable.text = text;
    lable.numberOfLines = 0;
    lable.textColor = [UIColor darkTextColor];
    [view.backView addSubview:lable];
    view.backView.layer.cornerRadius = 5;
    view.backView.backgroundColor = [UIColor colorWithRed:251/255.0 green:201/255.0 blue:0/255.0 alpha:1];
    [view popView];
}

@end
