//
//  ICECollectionMoveController.m
//  ZXT
//
//  Created by 1 on 2019/7/4.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICECollectionMoveController.h"

#define Margin 10

@interface ICECollectionMoveController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, retain) UICollectionViewCell * myCell;

@property (nonatomic, retain) NSIndexPath * myIndexPath;

@property (nonatomic, retain) NSMutableArray * colorArray;

@end

@implementation ICECollectionMoveController

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
        fl.minimumInteritemSpacing = Margin;
        fl.minimumLineSpacing = Margin;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavHegith) collectionViewLayout:fl];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.8 ];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
        [self.view addSubview: _collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    [self.collectionView reloadData];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.25f;
    [self.collectionView addGestureRecognizer:longPressGesture];
}

#pragma mark - 开始拖拽
- (void)longPressGesture:(UILongPressGestureRecognizer *)longGesture
{
    self.myIndexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            
            self.myCell = (UICollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.myIndexPath];
            
            [self.myCell.layer removeAnimationForKey:@"shake"];
        }
            break;
        case UIGestureRecognizerStateChanged:
            
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger numPreRow = 4;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - Margin*(numPreRow +1)) /numPreRow;
    return CGSizeMake(width, width);
}

#pragma mark -- dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.colorArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = self.colorArray[indexPath.row];
    return cell;
}

//调节item边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, Margin, 0, Margin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 删除数据源中初始位置的数据
    id objc = [self.colorArray objectAtIndex:sourceIndexPath.item];
    [self.colorArray removeObject:objc];
    
    // 将数据插入数据源中新的位置，实现数据源的更新
    [self.colorArray insertObject:objc atIndex:destinationIndexPath.item];
    
    NSArray *cellArray = [self.collectionView visibleCells];
    for (UICollectionViewCell *cell in cellArray ) {
        [cell.layer removeAllAnimations];
    }
}

- (NSMutableArray *)colorArray{
    if (!_colorArray) {
        _colorArray = [NSMutableArray arrayWithArray:@[[UIColor redColor],[UIColor blueColor],[UIColor blackColor],[UIColor brownColor],[UIColor grayColor],[UIColor greenColor],[UIColor orangeColor],[UIColor purpleColor]]];
    }
    return _colorArray;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
