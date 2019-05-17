//
//  ICETableViewCell.m
//  ZXT
//
//  Created by 1 on 2019/5/16.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICETableViewCell.h"

@interface ICETableViewCell()

@property (nonatomic , retain) UIImageView * icon;

@property (nonatomic , retain) UILabel * titleName;

@property (nonatomic , retain) UILabel * titleDescr;

@property (nonatomic , retain) UIView * bgV;

@end

@implementation ICETableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void) initUI {
    
    _bgV = [[UIView alloc] init];
    _icon = [[UIImageView alloc] init];
    _titleName = [[UILabel alloc] init];
    _titleDescr = [[UILabel alloc] init];
    
    [self.contentView addSubview:_bgV];
    [_bgV addSubview:_icon];
    [_bgV addSubview:_titleName];
    [_bgV addSubview:_titleDescr];
    
    _bgV.backgroundColor = [UIColor greenColor];
    _bgV.layer.cornerRadius = 5;
    _bgV.clipsToBounds = true;
    _icon.backgroundColor = [UIColor redColor];
    _titleDescr.font = [UIFont systemFontOfSize:12];
    _titleDescr.numberOfLines = 0;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _bgV.frame = CGRectMake(10, 10, self.width - 20, self.height - 20);
    _icon.frame = CGRectMake(10, 10, 20, 20);
    _titleName.frame = CGRectMake(_icon.right + 10, _icon.top, _bgV.width - 20 - _icon.right, 20);
    _titleDescr.frame = CGRectMake(10, _icon.bottom + 10, _bgV.width - 20, _bgV.height - 20 - _icon.bottom);
}

- (void)setModel:(ICEModel *)model{
    _model = model;
    //_icon.image = [UIImage imageNamed:model.icon];
    _titleName.text = model.titleName;
    _titleDescr.text = model.titleDescr;
}

@end
