//
//  ICEScanViewStyle.m
//  ZXT
//
//  Created by 1 on 2019/11/20.
//  Copyright © 2019 Free world co., LTD. All rights reserved.
//

#import "ICEScanViewStyle.h"

@implementation ICEScanViewStyle

#pragma mark -自定义4个角及矩形框颜色
+ (LBXScanViewStyle*)changeColor
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    //扫码框周围4个角的类型设置为在框的上面
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    //扫码框周围4个角绘制线宽度
    style.photoframeLineW = 6;
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    //显示矩形框
    style.isNeedShowRetangle = YES;
    //动画类型：网格形式，模仿支付宝
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];;
    //码框周围4个角的颜色
    style.colorAngle = [UIColor colorWithRed:65./255. green:174./255. blue:57./255. alpha:1.0];
    //矩形框颜色
    style.colorRetangleLine = [UIColor colorWithRed:247/255. green:202./255. blue:15./255. alpha:1.0];
    //非矩形框区域颜色
    style.notRecoginitonArea = [UIColor colorWithRed:247./255. green:202./255 blue:15./255 alpha:0.2];
    
    return style;
}

@end
