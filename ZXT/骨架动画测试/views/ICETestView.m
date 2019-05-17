//
//  ICETestView.m
//  ZXT
//
//  Created by 1 on 2019/5/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICETestView.h"

@interface ICETestView ()

@property (nonatomic, retain) UIImageView * icon;

@property (nonatomic, retain) UILabel * name;

@property (nonatomic, retain) UILabel * descr;

@end

@implementation ICETestView

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor redColor];
        [self addSubview:_icon];
    }
    return _icon;
}

- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        [self addSubview:_name];
    }
    return _name;
}

- (UILabel *)descr{
    if (!_descr) {
        _descr = [[UILabel alloc] init];
        _descr.numberOfLines = 0;
        [self addSubview:_descr];
    }
    return _descr;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void) initUI{
    self.icon.sd_layout.leftSpaceToView(self, 10).topSpaceToView(self, 10).widthIs(20).heightIs(20);
    
    self.name.sd_layout.leftSpaceToView(self.icon, 10).rightSpaceToView(self, 10).heightIs(20).topEqualToView(self.icon);
    
    self.descr.sd_layout.leftEqualToView(self.icon).topSpaceToView(self.icon, 10).rightSpaceToView(self, 10).autoHeightRatio(0);
}

- (void)setModel:(ICEModel *)model{
    _model = model;
    self.name.text = model.titleName;
    self.descr.text = model.titleDescr;
    [self layoutSubviews];
}

@end
