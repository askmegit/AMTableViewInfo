//
//  AMTableViewInfo.h
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/14.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTableViewSectionInfo.h"
#import "AMDZNEmptyInfo.h"

@protocol AMTableViewInfoDelegate <NSObject>

@optional
/**
 下拉刷新
 */
- (void)pullDownNewData;

/**
 上拉加载更多

 @return 是否有更多数据
 */
- (BOOL)pullUpMoreData;
@end

@interface AMTableViewInfo : NSObject
@property (nonatomic, assign) id <AMTableViewInfoDelegate> delegate;

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray  <AMTableViewSectionInfo *> * sectionsArr;
@property (nonatomic, strong) AMDZNEmptyInfo * dznEmptyInfo;
/**
 初始化TableViewInfo
 
 @param frame tableview frame
 @param style tableview 样式
 @return info实例
 */
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

/**
 根据 section 索引添加一个 cell 数据源

 @param cellInfo cell 数据源
 @param indexPath cell 索引
 */
- (void)addCellInfo:(AMTableViewCellInfo *)cellInfo forSectionIndex:(NSInteger)secIndex;

/**
 根据 section 索引添加多个 cell 数据源

 @param cellInfos cell 数据源数组
 @param secIndex section 索引
 */
- (void)addCellInfos:(NSArray *)cellInfos forSectionIndex:(NSInteger)secIndex;
/// 刷新表数据
- (void)reloadData;

/**
 数据请求失败时候停止 MJ 刷新,如果空试图存在,则显示空试图,没有则空表单
 */
- (void)endMJRefreshForRequestFailure;

/**
 数据请求成功时候停止刷新,并底部显示是否有更多数据
 
 @param hasNextPage 是否有下一页
 */
- (void)endMJRefreshIfHasNextPage:(BOOL)hasNextPage;
@end
