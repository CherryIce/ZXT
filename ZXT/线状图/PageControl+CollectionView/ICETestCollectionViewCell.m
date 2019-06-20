//
//  ICETestCollectionViewCell.m
//  ZXT
//
//  Created by 1 on 2019/6/19.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICETestCollectionViewCell.h"

@implementation ICETestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgV.layer.cornerRadius = 10;
    self.bgV.clipsToBounds = true;
}

@end
