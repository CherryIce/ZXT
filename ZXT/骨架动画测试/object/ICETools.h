//
//  ICETools.h
//  ZXT
//
//  Created by 1 on 2019/5/17.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICETools : NSObject

//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;

//根据高度度求宽度  text 计算的内容  Height 计算的高度 font字体大小
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;

@end

NS_ASSUME_NONNULL_END
