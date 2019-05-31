//
//  ICEWatchImageView.m
//  ZXT
//
//  Created by 1 on 2019/5/28.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEWatchImageView.h"

#import "ICEImageViewCell.h"
#import "ICEImageView.h"

#import "UIImage+ICEImage.h"

#define showPageLabelWIDTH 100
#define showPageLabelHEIGHT 25
#define padding 10
#define bottomHEIGHT 70

/** 用CollectionView 试试  */
@interface ICEWatchImageView()<UIScrollViewDelegate>

//当前下标
@property (nonatomic, assign) NSInteger currentIndex;
//全部个数
@property (nonatomic, assign) NSInteger totals;
//显示文本
@property (nonatomic, retain) UILabel * showPageLabel;

@property (nonatomic , retain) UIScrollView * scrollView;

@end

@implementation ICEWatchImageView

- (UILabel *)showPageLabel{
    if (!_showPageLabel) {
        _showPageLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - showPageLabelWIDTH)/2, (kNavHegith - showPageLabelHEIGHT)/2, showPageLabelWIDTH, showPageLabelHEIGHT)];
        _showPageLabel.textAlignment = NSTextAlignmentCenter;
        _showPageLabel.textColor = [UIColor whiteColor];
        [self addSubview:_showPageLabel];
    }
    return _showPageLabel;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.showPageLabel.frame), self.frame.size.width, self.frame.size.height - bottomHEIGHT - CGRectGetMaxY(self.showPageLabel.frame))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        // 隐藏滑动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        // 取消反弹
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray index:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor darkTextColor];
        
        for (NSInteger i = 0; i < dataArray.count; i ++) {

            ICEImageView * imageView = [[ICEImageView alloc] initWithFrame:CGRectMake(self.scrollView.frame.size.width * i, 0, self.scrollView.width, self.scrollView.height)];
            imageView.userInteractionEnabled = true;
            imageView.tag = 2000+i;
            [self.scrollView addSubview:imageView];
            //如果是image 显示占位图
            if ([dataArray[i] isKindOfClass:[UIImage class]])
                [imageView.icon setImage:[UIImage imageNamed:@"imagePlaceholder"]];//dataArray[i]
            else
                [imageView.icon sd_setImageWithURL:dataArray[i] placeholderImage:[UIImage imageNamed:@"imagePlaceholder"]];

            //单击手势
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissBack)];
            [imageView addGestureRecognizer:tap];
        }
        
        //获取下表和image数据组
        _currentIndex = index;
        _totals = dataArray.count;
        
        self.scrollView.contentSize = CGSizeMake(frame.size.width * dataArray.count, 0);
        
        [self.showPageLabel setText:[NSString stringWithFormat:@"%ld / %ld",(long)index+1,(long)dataArray.count]];
        [self.scrollView setContentOffset:CGPointMake(frame.size.width * index,0) animated:false];
        
        UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), frame.size.width, bottomHEIGHT)];
        [self addSubview:bottomView];
        
        NSArray * imgArr = @[@"UIImageLeft",@"UIImageRight",@"ImageUpMirrored"];
        for (int i = 0; i < 3; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(frame.size.width/3*i, padding, frame.size.width/3, bottomHEIGHT - 3*padding)];
            btn.tag = 400 + i;
            [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:btn];
        }
    }
    return self;
}

#pragma mark - ScrollerView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger scrollIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scrollIndex != _currentIndex) {
         //重置上一个缩放过的视图
         ICEImageView * zoomView  = (ICEImageView *)scrollView.subviews[_currentIndex];
         [zoomView pictureZoomWithScale:1.0];
        _currentIndex = scrollIndex;
    }
    [self.showPageLabel setText:[NSString stringWithFormat:@"%ld / %ld",(long)_currentIndex+1,(long)_totals]];
}

#pragma mark 缩放拉拽
//点击消失
- (void) disMissBack
{
    [self removeFromSuperview];
}

#pragma mark 旋转
- (void) btnClick:(UIButton *) sender{
    switch (sender.tag) {
        case 400:{
            //逆时针旋转90
            ICEImageView * v = (ICEImageView *)self.scrollView.subviews[_currentIndex];
            UIImage * image = [v.icon.image rotate:UIImageOrientationLeft];
            v.icon.image = image;
        }
            break;
        case 401:{
            //x顺时针旋转90
            ICEImageView * v = (ICEImageView *)self.scrollView.subviews[_currentIndex];
            UIImage * image = [v.icon.image rotate:UIImageOrientationRight];
            v.icon.image = image;
        }
            break;
        case 402:{
            //左右翻转
            ICEImageView * v = (ICEImageView *)self.scrollView.subviews[_currentIndex];
            UIImage * image = [v.icon.image rotate:UIImageOrientationUpMirrored];
            v.icon.image = image;
        }
            break;
        default:
            break;
    }
}

@end
