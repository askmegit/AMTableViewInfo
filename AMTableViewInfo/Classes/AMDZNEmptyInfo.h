//
//  AMDZNEmptyInfo.h
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/15.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMDZNEmptyInfo : NSObject
/// 空视图标题
@property (nonatomic, copy)  NSAttributedString * dznTitle;
/// 空视图描述
@property (nonatomic, copy)  NSAttributedString * dznDescription;
/// 空视图按钮标题
@property (nonatomic, copy)  NSAttributedString * dznButtonTitle;
/// 空视图背景色
@property (nonatomic, strong) UIColor * dznBackgroundColor;
/// 空视图点击事件
@property (nonatomic, copy)  void(^dznButtonEvent)(void);
- (NSAttributedString *)attriStrWithText:(NSString *)text attributes:(NSDictionary *)attributes;
@end
