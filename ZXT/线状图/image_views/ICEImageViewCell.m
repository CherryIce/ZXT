//
//  ICEImageViewCell.m
//  ZXT
//
//  Created by 1 on 2019/5/28.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEImageViewCell.h"

@implementation ICEImageViewCell

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self drawRect:self.bounds];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.icon.frame = self.bounds;
    self.deleteBtn.frame = CGRectMake(self.bounds.size.width - 30, 0, 30, 30);
    
    self.mb_v.frame = self.bounds;
    self.progressLab.frame = CGRectMake(self.bounds.size.width/6, self.bounds.size.height/2 - 10, self.bounds.size.width * 2 / 3, 20);
    self.progressRates.frame = CGRectMake(CGRectGetMinX(self.progressLab.frame), CGRectGetMaxY(self.progressLab.frame) + 5, self.progressLab.frame.size.width, 5);
    self.progressRates.layer.cornerRadius = 2.5;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateCell:(id)obj{
    //图片 or 链接
    if ([obj isKindOfClass:[UIImage class]]){
        UIImage * image = obj;
        [self.icon setImage:image];
    }
    else{
        NSString * string = obj;
       [self.icon sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"imagePlaceholder"]];
    }
}

@end
