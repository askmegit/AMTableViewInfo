//
//  AMTableViewSectionInfo.m
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/14.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import "AMTableViewSectionInfo.h"

@implementation AMTableViewSectionInfo
- (NSMutableArray<AMTableViewCellInfo *> *)cellsArr{
    if(_cellsArr == nil){
        _cellsArr = [NSMutableArray array];
    }
    return _cellsArr;
}
- (void)addCellInfo:(AMTableViewCellInfo *)cellInfo{
    if(cellInfo){
        [self.cellsArr addObject:cellInfo];
    }
}
@end
