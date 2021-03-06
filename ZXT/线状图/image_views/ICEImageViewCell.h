//
//  ICEImageViewCell.h
//  ZXT
//
//  Created by 1 on 2019/5/28.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDImageCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface ICEImageViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIView *mb_v;
@property (weak, nonatomic) IBOutlet UILabel *progressLab;
@property (weak, nonatomic) IBOutlet UIProgressView *progressRates;

- (void) updateCell:(id)obj;

@end

NS_ASSUME_NONNULL_END
