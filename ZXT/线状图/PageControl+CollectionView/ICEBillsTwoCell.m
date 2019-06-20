//
//  ICEBillsTwoCell.m
//  ZXT
//
//  Created by 1 on 2019/6/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEBillsTwoCell.h"

@implementation ICEBillsTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;

    self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.shadowColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 5);
    self.layer.shadowOpacity = 0.5;
    
    //可以xib中设置
    self.yishouBtn.tag = 1000;
    self.weishouBtn.tag = 2000;
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick1:)];
    [self.yishouView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick2:)];
    [self.weishouView addGestureRecognizer:tap2];
}

- (void) tapClick1:(UITapGestureRecognizer *) sender
{
    if (_yShouViewCall) {
        _yShouViewCall(sender.view);
    }
}

- (void) tapClick2:(UITapGestureRecognizer *) sender
{
    if (_wShouViewCall) {
        _wShouViewCall(sender.view);
    }
}

- (void)updateCellWithObj:(id)obj
{
    
}


@end
