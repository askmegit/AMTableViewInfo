//
//  AMDZNEmptyInfo.m
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/15.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import "AMDZNEmptyInfo.h"
#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation AMDZNEmptyInfo
- (NSAttributedString *)attriStrWithText:(NSString *)text attributes:(NSDictionary *)attributes{
    return [[NSAttributedString alloc]initWithString:text attributes:attributes];
}
- (NSAttributedString *)dznTitle{
    if (_dznTitle == nil) {
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName:[UIColor darkGrayColor] };
        _dznTitle = [self attriStrWithText:@"数据加载失败" attributes:attributes];
    }
    return _dznTitle;
}
- (NSAttributedString *)dznDescription{
    if (_dznDescription == nil) {
        NSString *text = @"请检查你的手机是否联网\n点击按钮尝试重新加载";
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping; paragraph.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName:[UIColor lightGrayColor], NSParagraphStyleAttributeName:paragraph };
        _dznDescription = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    }
    return _dznDescription;
}
- (NSAttributedString *)dznButtonTitle{
    if (_dznButtonTitle == nil) {
        NSString *text = @"网络不给力，请点击重试哦~";
        NSMutableAttributedString *_dznButtonTitle = [[NSMutableAttributedString alloc] initWithString:text];
        // 设置所有字体大小为 #15
        [_dznButtonTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, text.length)];
        // 设置所有字体颜色为浅灰色
        [_dznButtonTitle addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, text.length)];
        // 设置指定4个字体为蓝色
        [_dznButtonTitle addAttribute:NSForegroundColorAttributeName value:RGBHex(0x007EE5) range:NSMakeRange(7, 4)];
    }
    return _dznButtonTitle;
}
- (UIColor *)dznBackgroundColor{
    if (_dznBackgroundColor == nil) {
        _dznBackgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _dznBackgroundColor;
}
@end
