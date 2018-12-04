//
//  AMTableViewCellInfo.h
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/14.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AMTableviewCellCreateType) {
    AMTableviewCellCreateTypeNone = 0,
    AMTableviewCellCreateTypeNib,
    AMTableviewCellCreateTypeClass
};

@interface AMTableViewCellInfo : NSObject

@property (nonatomic, assign) AMTableviewCellCreateType  cellCreateType;
/// 系统 cell 样式, 默认 UITableViewCellStyleDefault
@property (nonatomic, assign) UITableViewCellStyle  cellStyle;
/// cell 选中后的样式,默认 UITableViewCellSelectionStyleNone
@property (nonatomic, assign) UITableViewCellSelectionStyle  selectionStyle;
/// cell class
@property (nonatomic, weak)  Class cellClass;
/// cell reusedID
@property (nonatomic, copy)  NSString * reusedID;
/// cell height
@property (nonatomic, assign) CGFloat  cellHeight;
/// text
@property (nonatomic, copy)  NSString * text;
/// detailText
@property (nonatomic, copy)  NSString * detailText;

/// cell 属性更新
@property (nonatomic, copy)  void(^cellUpdateValuesForKeysWithDictionary)(NSDictionary<NSString *, id> * keyedValues);
/// cell 重新载入事件
@property (nonatomic, copy)  void(^cellReload)(void);
/// cell 点击事件
@property (nonatomic, copy)  void(^cellEvent)(id  cellInfo);
@end
