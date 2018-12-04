//
//  AMTableViewSectionInfo.h
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/14.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTableViewCellInfo.h"


@interface AMTableViewSectionInfo : NSObject
/// cell 数据源
@property (nonatomic, strong)  NSMutableArray <AMTableViewCellInfo *> * cellsArr;

/**
 添加 cell 数据

 @param cellInfo cell 模型类
 */
- (void)addCellInfo:(AMTableViewCellInfo *)cellInfo;
@end
