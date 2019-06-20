//
//  CWPageControl.m
//  CWCarousel
//
//  Created by chenwang on 2018/7/16.
//  Copyright © 2018年 ChenWang. All rights reserved.
//

#import "CWPageControl.h"

#define h 4
#define padding  4
#define MaxW  16
#define MinW  8

@interface CWPageControl () {
    
}
@property (nonatomic, assign) NSInteger myPageNumbers;
@property (nonatomic, assign) NSInteger myCurrentPage;

@property (nonatomic, strong) NSMutableArray<UIButton *> *indicatorArr;
@property (nonatomic, strong) UIButton    *currentIndicator;
@end
@implementation CWPageControl
@synthesize currentPage;
@synthesize pageNumbers;
#pragma mark - INITIAL
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self configureView];
    }
    return self;
}
#pragma mark - PROPERTY
- (void)setCurrentPage:(NSInteger)currentPage {
    self.myCurrentPage = currentPage;
    if (currentPage >= self.indicatorArr.count) {
        return;
    }
    [self updateFrameWithIndex:currentPage];
    
}

- (void)setPageNumbers:(NSInteger)pageNumbers {
    self.myPageNumbers = pageNumbers;
    [self createIndicator];
}

- (NSInteger)currentPage {
    return self.currentPage;
}
- (NSInteger)pageNumbers {
    return self.myPageNumbers;
}
#pragma mark - LOGIC HELPER
- (void)configureView {
    
}

- (void)createIndicator {
    //第一个宽度+间隙个数的宽度+剩余个数的宽度
    CGFloat total_w = MaxW + padding * (self.pageNumbers - 1) + MinW * (self.pageNumbers - 1);
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - total_w)/2, 0, total_w, CGRectGetHeight(self.frame))];
    [self addSubview:v];
     NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.pageNumbers];
    
    self.currentIndicator = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.currentIndicator setFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2 - h /2, MaxW, h)];
    self.currentIndicator.layer.cornerRadius = h/2;
    [v addSubview:self.currentIndicator];
    self.currentIndicator.backgroundColor = [UIColor colorWithRed:255/255.0 green:221/255.0 blue:0/255.0 alpha:1.0];
    self.currentIndicator.layer.zPosition = 999;
    [arr addObject:self.currentIndicator];
    
    for(int i = 1; i < self.pageNumbers; i ++) {
        CGFloat x = MaxW + padding + (MinW + padding) * (i - 1);
        UIButton  *indictor = [UIButton buttonWithType:UIButtonTypeCustom];
        [indictor setFrame:CGRectMake(x, CGRectGetHeight(self.frame)/2 - h /2, MinW, h)];
        indictor.layer.cornerRadius = h/2;
        [v addSubview:indictor];
        indictor.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [arr addObject:indictor];
    }
    self.indicatorArr = [NSMutableArray arrayWithArray:arr];
}

- (void) updateFrameWithIndex:(NSInteger)index{
    
    for (int i = 0; i < index; i++) {
        UIButton * button1 = self.indicatorArr[i];
        [button1 setFrame:CGRectMake((MinW+padding)*i, (CGRectGetHeight(self.frame) - h)/2, MinW, h)];
        button1.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [self.indicatorArr replaceObjectAtIndex:i withObject:button1];
    }
    
    UIButton * button = self.indicatorArr[index];
    [button setFrame:CGRectMake((MinW+padding)*index, (CGRectGetHeight(self.frame) - h)/2, MaxW, h)];
    button.backgroundColor = [UIColor colorWithRed:255/255.0 green:221/255.0 blue:0/255.0 alpha:1.0];
    [self.indicatorArr replaceObjectAtIndex:index withObject:button];
    
    int next = (int)index+1;
    for (int j = next; j < self.pageNumbers; j++) {
        UIButton * button2 = self.indicatorArr[j];
        [button2 setFrame:CGRectMake( CGRectGetMaxX(button.frame) + padding + (MinW+padding)*(j-next), (CGRectGetHeight(self.frame) - h)/2, MinW, h)];
        button2.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        [self.indicatorArr replaceObjectAtIndex:j withObject:button2];
    }
}


@end
