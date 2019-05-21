//
//  ICEXibView.m
//  ZXT
//
//  Created by 1 on 2019/5/21.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEXibView.h"

@interface ICEXibView()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *titleDescr;

@end

@implementation ICEXibView

// https://www.cnblogs.com/hero11223/p/6881848.html
// xib "File's Owner" 的class 继承为:ICEXibView(即自定义创建的视图类)

- (void)setModel:(ICEModel *)model{
    _titleName.text = model.titleName;
    _titleDescr.text = model.titleDescr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
