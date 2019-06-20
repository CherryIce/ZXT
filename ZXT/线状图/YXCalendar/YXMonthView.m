//
//  YXMonthView.m
//  Calendar
//
//  Created by Vergil on 2017/7/6.
//  Copyright © 2017年 Vergil. All rights reserved.
//

#import "YXMonthView.h"

@interface YXMonthView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionV;

@end

@implementation YXMonthView

- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _currentDate = date;
        [self setCollectionView];
    }
    return self;
}

//MARK: - settingView
- (void)setCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((self.frame.size.width - 1) / 7, dayCellH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 6 * dayCellH) collectionViewLayout:layout];
    _collectionV.scrollEnabled = NO;
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    _collectionV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionV];
    
    [_collectionV registerNib:[UINib nibWithNibName:@"YXDayCell" bundle:nil] forCellWithReuseIdentifier:@"YXDayCell"];
    
}

//MARK: - setMethod

- (void)setEventArray:(NSArray *)eventArray {
    _eventArray = eventArray;
    [_collectionV reloadData];
}

//MARK: - dateMethod

//获取cell的日期 (日 -> 六   格式,如需修改星期排序只需修改该函数即可)
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath {
    NSCalendar *myCalendar = [NSCalendar currentCalendar];
    NSDate *firstOfMonth = [[YXDateHelpObject manager] GetFirstDayOfMonth:_currentDate];
    NSInteger ordinalityOfFirstDay = [myCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:firstOfMonth];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = (1 - ordinalityOfFirstDay) + indexPath.item;
    return [myCalendar dateByAddingComponents:dateComponents toDate:firstOfMonth options:0];
}

//MARK: - collectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[YXDateHelpObject manager] getRows:_currentDate] * 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YXDayCell" forIndexPath:indexPath];
    /** 根据情况显示不同的东西 */
    NSDate *cellDate = [self dateForCellAtIndexPath:indexPath];
    cell.selectDate = _selectDate;
    cell.currentDate = _currentDate;
    [cell updateWithObj:cellDate];
    return cell;
}

//MARK: - collectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectDate = [self dateForCellAtIndexPath:indexPath];
    if (_sendSelectDate) {
        _sendSelectDate(_selectDate);
    }
    //选中需要改变颜色才刷新
    //[_collectionV reloadData];
}

@end
