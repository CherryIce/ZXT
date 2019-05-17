//
//  ICETableViewCell.h
//  ZXT
//
//  Created by 1 on 2019/5/16.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ICEModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ICETableViewCell : UITableViewCell

@property (nonatomic , copy) ICEModel * model;

@end

NS_ASSUME_NONNULL_END
