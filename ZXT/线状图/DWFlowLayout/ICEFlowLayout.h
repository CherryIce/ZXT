//
//  ICEFlowLayout.h
//  ZXT
//
//  Created by 1 on 2019/6/18.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICEFlowLayout : UICollectionViewFlowLayout

@property CGFloat move_x;

@property BOOL isPagingEnabled;

-(void)setPagingEnabled:(BOOL)isPagingEnabled;

@end

NS_ASSUME_NONNULL_END
