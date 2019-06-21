//
//  ICEPageControl.m
//  ZXT
//
//  Created by 1 on 2019/6/18.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEPageControl.h"

#define h 4
#define padding  4
#define MaxW  16
#define MinW  8

@interface ICEPageControl()

@property (nonatomic, assign) NSInteger myPageNumbers;
@property (nonatomic, assign) NSInteger myCurrentPage;

@property (nonatomic, strong) NSMutableArray<UIButton *> *indicatorArr;
@property (nonatomic, strong) UIButton    *currentIndicator;

@end

@implementation ICEPageControl

#pragma mark - INITIAL
- (instancetype)initWithFrame:(CGRect)frame pageNumbers:(NSInteger)pageNumbers {
    if(self = [super initWithFrame:frame]) {
//        self.myPageNumbers = pageNumbers;
//        [self createIndicator];
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

- (void)setPageNumbers:(NSInteger)pageNumbers{
    self.myPageNumbers = pageNumbers;
    [self createIndicator];
}

- (void)createIndicator {
    //第一个宽度+间隙个数的宽度+剩余个数的宽度
    CGFloat total_w = MaxW + padding * (self.myPageNumbers - 1) + MinW * (self.myPageNumbers - 1);
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - total_w)/2, 0, total_w, CGRectGetHeight(self.frame))];
    [self addSubview:v];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.myPageNumbers];
    
    self.currentIndicator = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.currentIndicator setFrame:CGRectMake(0, CGRectGetHeight(self.frame)/2 - h /2, MaxW, h)];
    self.currentIndicator.tag = 0;
    self.currentIndicator.layer.cornerRadius = h/2;
    [v addSubview:self.currentIndicator];
    self.currentIndicator.backgroundColor = [UIColor redColor];
    self.currentIndicator.layer.zPosition = 999;
    [arr addObject:self.currentIndicator];
    
    for(int i = 1; i < self.myPageNumbers; i ++) {
        CGFloat x = MaxW + padding + (MinW + padding) * (i - 1);
        UIButton  *indictor = [UIButton buttonWithType:UIButtonTypeCustom];
        [indictor setFrame:CGRectMake(x, CGRectGetHeight(self.frame)/2 - h /2, MinW, h)];
        indictor.layer.cornerRadius = h/2;
        [v addSubview:indictor];
        indictor.backgroundColor = [UIColor blueColor];
        indictor.tag = i;
        [arr addObject:indictor];
    }
    self.indicatorArr = [NSMutableArray arrayWithArray:arr];
}

- (void) updateFrameWithIndex:(NSInteger)index{
    
    for (int i = 0; i < index; i++) {
        UIButton * button1 = self.indicatorArr[i];
        [button1 setFrame:CGRectMake((MinW+padding)*i, (CGRectGetHeight(self.frame) - h)/2, MinW, h)];
        button1.backgroundColor = [UIColor blueColor];
        [self.indicatorArr replaceObjectAtIndex:i withObject:button1];
    }
    
    UIButton * button = self.indicatorArr[index];
    [button setFrame:CGRectMake((MinW+padding)*index, (CGRectGetHeight(self.frame) - h)/2, MaxW, h)];
    button.backgroundColor = [UIColor redColor];
    [self.indicatorArr replaceObjectAtIndex:index withObject:button];
    
    int next = (int)index+1;
    for (int j = next; j < self.myPageNumbers; j++) {
        UIButton * button2 = self.indicatorArr[j];
        [button2 setFrame:CGRectMake( CGRectGetMaxX(button.frame) + padding + (MinW+padding)*(j-next), (CGRectGetHeight(self.frame) - h)/2, MinW, h)];
        button2.backgroundColor = [UIColor blueColor];
        [self.indicatorArr replaceObjectAtIndex:j withObject:button2];
    }
}

@end
