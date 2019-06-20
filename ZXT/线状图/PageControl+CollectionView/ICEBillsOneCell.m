//
//  ICEBillsOneCell.m
//  ZXT
//
//  Created by 1 on 2019/6/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEBillsOneCell.h"

@implementation ICEBillsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 7;
    self.contentView.layer.cornerRadius = 7.0f;
    self.contentView.layer.borderWidth = 0.7f;
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
    //阴影：
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(-10,-10);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.4f;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick1:)];
    [self.lastMonthView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick2:)];
    [self.currentMonthView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick3:)];
    [self.yushouView addGestureRecognizer:tap3];
}

- (void) tapClick1:(UITapGestureRecognizer *) sender
{
    if (_lastMonthCall) {
        _lastMonthCall(sender.view);
    }
}

- (void) tapClick2:(UITapGestureRecognizer *) sender
{
    if (_currentMonthCall) {
        _currentMonthCall(sender.view);
    }
}

- (void) tapClick3:(UITapGestureRecognizer *) sender
{
    if (_yushouCall) {
        _yushouCall(sender.view);
    }
}

- (void)updateCellWithObj:(id)obj
{
    
}

@end
