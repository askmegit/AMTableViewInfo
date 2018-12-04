//
//  AMTableViewCell.m
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/14.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import "AMTableViewCell.h"
#import "AMTableViewCellInfo.h"

@implementation AMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setCellInfo:(AMTableViewCellInfo *)cellInfo{
    if(_cellInfo != cellInfo){
        _cellInfo = cellInfo;
        self.textLabel.text = cellInfo.text;
        self.detailTextLabel.text = cellInfo.detailText;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
