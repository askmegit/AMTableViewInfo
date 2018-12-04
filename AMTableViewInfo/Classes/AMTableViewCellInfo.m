//
//  AMTableViewCellInfo.m
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/14.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import "AMTableViewCellInfo.h"

@implementation AMTableViewCellInfo
- (NSString *)reusedID{
    if(_reusedID == nil){
        _reusedID = @"AMTableViewCell";
    }
    return _reusedID;
}
- (Class)cellClass{
    if(_cellClass == nil){
        _cellClass = NSClassFromString(self.reusedID);
    }
    return _cellClass;
}
@end
