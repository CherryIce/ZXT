//
//  ICECollectionViewCell.m
//  ZXT
//
//  Created by 1 on 2019/5/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICECollectionViewCell.h"

@implementation ICECollectionViewCell
{
    __weak IBOutlet UILabel *name;
    __weak IBOutlet UILabel *descr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ICEModel *)model {
    _model = model;
    name.backgroundColor = [UIColor clearColor];
    descr.backgroundColor = [UIColor clearColor];
}

@end
