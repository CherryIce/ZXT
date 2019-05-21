//
//  ICECodeCollectionViewCell.m
//  ZXT
//
//  Created by 1 on 2019/5/21.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICECodeCollectionViewCell.h"

@interface ICECodeCollectionViewCell()

@property (nonatomic,retain) UIImageView * icon;

@property (nonatomic,retain) UILabel * titleStr;

@property (nonatomic,retain) UILabel * descrStr;

@end

@implementation ICECodeCollectionViewCell

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor redColor];
    }
    return _icon;
}

- (UILabel *)titleStr{
    if (!_titleStr) {
        _titleStr = [[UILabel alloc] init];
    }
    return _titleStr;
}

- (UILabel *)descrStr{
    if (!_descrStr) {
        _descrStr = [[UILabel alloc] init];
        _descrStr.font = [UIFont systemFontOfSize:14];
        _descrStr.numberOfLines = 0;
    }
    return _descrStr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.icon];
        [self addSubview:self.titleStr];
        [self addSubview:self.descrStr];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.icon.frame = CGRectMake(10, 10, 20, 20);
    
    self.titleStr.frame = CGRectMake(self.icon.right + 10, 10, self.width - 20 - self.icon.right, 20);
    
    self.descrStr.frame = CGRectMake(10, self.icon.bottom + 10, self.width - 20, self.height - 50);
}

- (void)setModel:(ICEModel *)model {
    _model = model;
    
    self.titleStr.text = model.titleName;
    self.descrStr.text = model.titleDescr;
}

@end
