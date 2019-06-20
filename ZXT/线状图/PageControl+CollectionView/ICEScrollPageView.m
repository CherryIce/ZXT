//
//  ICEScrollPageView.m
//  ZXT
//
//  Created by 1 on 2019/6/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEScrollPageView.h"

#import "CWPageControl.h"
#import "ICEBillsOneCell.h"
#import "ICEBillsTwoCell.h"

#define count 2

@interface ICEScrollPageView ()<CWCarouselDatasource, CWCarouselDelegate>

@property (nonatomic,strong) CWPageControl * pageControl;

@property (nonatomic , strong) UIView * bgView;

@end

static NSString * cellID1 = @"ICEBillsOneCell";
static NSString * cellID2 = @"ICEBillsTwoCell";

@implementation ICEScrollPageView

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30)];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (CWPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[CWPageControl alloc] initWithFrame:CGRectMake(10, self.bgView.frame.size.height + 5,[UIScreen mainScreen].bounds.size.width - 20, 5)];
        
    }
    return _pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(id)dataSource{
    if (self == [super initWithFrame:frame]) {
        [self initUIWithDataSource:dataSource];
    }
    return self;
}

- (void) initUIWithDataSource:(id) dataSource{
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_H_2];
    /**  调整大小和间隙 */
    flowLayout.maxScale = 1.0;
    flowLayout.minScale = 1.0;
    flowLayout.itemSpace_H = 25; /**  调整大小和间隙 */
    flowLayout.itemWidth = self.bgView.frame.size.width*0.85;
    
    // 使用layout创建视图(使用masonry 或者 系统api)
    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:CGRectZero
                                                    delegate:self
                                                  datasource:self
                                                  flowLayout:flowLayout];
    carousel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bgView addSubview:carousel];
    
    NSDictionary *dic = @{@"view" : carousel};
    [self.bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:dic]];
    [self.bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:dic]];
    
    
    carousel.isAuto = false;
    carousel.endless = false;
    carousel.backgroundColor = [UIColor clearColor];
    
    /* 自定pageControl */
    self.pageControl.pageNumbers = count;
    self.pageControl.currentPage = 0;
    carousel.customPageControl = self.pageControl;

    [carousel registerNibView:cellID1 identifier:cellID1];
    [carousel registerNibView:cellID2 identifier:cellID2];
    [carousel freshCarousel];
    self.carousel = carousel;
}

#pragma mark - CWCarouselDatasource, CWCarouselDelegate
- (NSInteger)numbersForCarousel {
    return count;
}

- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    NSLog(@"----------->%zd \n %zd",indexPath.row,index);
    if (index == 0) {
        ICEBillsOneCell * cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:cellID1 forIndexPath:indexPath];
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
    ICEBillsTwoCell * cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:cellID2 forIndexPath:indexPath];
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

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"...%ld...", (long)index);
}


- (void)CWCarousel:(CWCarousel *)carousel didStartScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
    NSLog(@"开始滑动: %ld", (long)index);
}


- (void)CWCarousel:(CWCarousel *)carousel didEndScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
    NSLog(@"结束滑动: %ld", (long)index);
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
