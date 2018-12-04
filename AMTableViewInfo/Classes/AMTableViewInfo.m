//
//  AMTableViewInfo.m
//  AMTableViewInfo_Example
//
//  Created by 👀💋💋💋 😊☺️ on 2018/11/14.
//  Copyright © 2018年 83076130@qq.com. All rights reserved.
//

#import "AMTableViewInfo.h"
#import "AMTableViewCell.h"

#import <MJRefresh/MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


#define weakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o
#define strongObj(o) autoreleasepool{} __strong typeof(o##Weak) o##Strong = o##Weak


@interface  AMTableViewInfo()<UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    CGRect _tableViewFrame;
    UITableViewStyle _tableViewStyle;
}

@end

@implementation AMTableViewInfo
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super init];
    if(self){
        _tableViewFrame = frame;
        _tableViewStyle = style;
    }
    return self;
}
- (NSMutableArray *)sectionsArr{
    if(_sectionsArr == nil ){
        _sectionsArr = [NSMutableArray array];
    }
    return _sectionsArr;
}
- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:_tableViewFrame style:_tableViewStyle];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        // 防止 tableView 没有数据时候出现空单元格
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (void)setDznEmptyInfo:(AMDZNEmptyInfo *)dznEmptyInfo{
    if (_dznEmptyInfo != dznEmptyInfo) {
        _dznEmptyInfo = dznEmptyInfo;
        self.tableView.emptyDataSetDelegate = self;
        self.tableView.emptyDataSetSource = self;
    }
}
#pragma mark - 对 MJRefresh 的相关配置和停止刷新
- (void)setDelegate:(id<AMTableViewInfoDelegate>)delegate{
    if (_delegate != delegate) {
        _delegate = delegate;
        // MARK: 下拉刷新
        if (self.delegate && [self.delegate respondsToSelector:@selector(pullDownNewData)]) {
            if (self.tableView.mj_header) {
                NSLog(@"mj_header is existd");
            }else{
                @weakObj(self);
                MJRefreshNormalHeader * refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//                    [selfWeak.sectionsArr removeAllObjects];
                    if(selfWeak.tableView.mj_footer.state == MJRefreshStateNoMoreData){
                        [selfWeak.tableView.mj_footer resetNoMoreData];
                    }
                    [selfWeak.delegate pullDownNewData];
                }];
                refreshHeader.lastUpdatedTimeLabel.hidden = YES;
                self.tableView.mj_header = refreshHeader;
            }
        }
        // MARK: 上拉加载
        if(self.delegate && [self.delegate respondsToSelector:@selector(pullUpMoreData)]){
            if (self.tableView.mj_footer) {
                NSLog(@"mj_footer is existd");
            }else{
                @weakObj(self);
                MJRefreshAutoNormalFooter * refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    if ([selfWeak.delegate pullUpMoreData] == NO) {//当没有下一页的时候显示没有更多数据
                        [selfWeak.tableView.mj_footer endRefreshingWithNoMoreData];
                    }
                }];
                self.tableView.mj_footer = refreshFooter;
            }
        }
    }
}
- (void)endMJRefreshForRequestFailure{
//    __weak typeof(self) selfWeak = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (selfWeak.tableView.mj_header.isRefreshing) {
//            [selfWeak.tableView.mj_header endRefreshing];
//        }else if(selfWeak.tableView.mj_footer.isRefreshing){
//            [selfWeak.tableView.mj_footer endRefreshing];
//        }
//    });
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }else if(self.tableView.mj_footer.isRefreshing){
        [self.tableView.mj_footer endRefreshing];
    }
    __weak typeof(self) selfWeak = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfWeak.sectionsArr removeAllObjects];
        [selfWeak reloadData];
    });
}
- (void)endMJRefreshIfHasNextPage:(BOOL)hasNextPage{
//    @weakObj(self);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (hasNextPage == NO) {
//            selfWeak.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//        }
//        if(selfWeak.tableView.mj_header.isRefreshing){
//            [selfWeak.tableView.mj_header endRefreshing];
//        }else if (selfWeak.tableView.mj_footer.isRefreshing){
//            if (hasNextPage == NO) {
//                [selfWeak.tableView.mj_footer endRefreshingWithNoMoreData];
//            }else{
//                [selfWeak.tableView.mj_footer endRefreshing];
//            }
//        }
//    });
    
    if (hasNextPage == NO) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    if(self.tableView.mj_header.isRefreshing){
        [self.tableView.mj_header endRefreshing];
    }else if (self.tableView.mj_footer.isRefreshing){
        if (hasNextPage == NO) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }
}
#pragma mark - 添加 cell
- (void)addCellInfo:(AMTableViewCellInfo *)cellInfo forSectionIndex:(NSInteger)secIndex{
    NSString * desc = [NSString stringWithFormat:@"secIndex beyond out of rang: 0 =< secIndex 0 <= %lu",(unsigned long)self.sectionsArr.count];
    NSAssert(secIndex >= 0 && secIndex <= self.sectionsArr.count, desc);
    AMTableViewSectionInfo * sectionInfo = nil;
    if(secIndex == self.sectionsArr.count){// 需要新建 sectionInfo
        sectionInfo = [AMTableViewSectionInfo new];
        [self.sectionsArr addObject:sectionInfo];
    }
    sectionInfo = [self.sectionsArr objectAtIndex:secIndex];
    [sectionInfo addCellInfo:cellInfo];
}
- (void)addCellInfos:(NSArray *)cellInfos forSectionIndex:(NSInteger)secIndex{
    
}
- (AMTableViewCellInfo *)cellInfoForIndexPath:(NSIndexPath *)indexPath{

    AMTableViewSectionInfo * sectionInfo = [self.sectionsArr objectAtIndex:indexPath.section];
    AMTableViewCellInfo * cellInfo = [sectionInfo.cellsArr objectAtIndex:indexPath.row];
    return cellInfo;
}

#pragma mark - Tableview dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionsArr.count;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AMTableViewSectionInfo * sectionInfo = [self.sectionsArr objectAtIndex:section];
    return sectionInfo.cellsArr.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AMTableViewCellInfo * cellInfo = [self cellInfoForIndexPath:indexPath];
    AMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellInfo.reusedID];
    if(cell == nil){
        if(cellInfo.cellCreateType == AMTableviewCellCreateTypeNib){
            cell = [[NSBundle mainBundle]loadNibNamed:cellInfo.reusedID owner:self options:nil].firstObject;
        }else{
            cell = [[cellInfo.cellClass alloc]initWithStyle:cellInfo.cellStyle reuseIdentifier:cellInfo.reusedID];
        }
    }
    cell.selectionStyle = cellInfo.selectionStyle;
    @weakObj(self);
    cellInfo.cellReload = ^{
        [selfWeak.tableView beginUpdates];
        [selfWeak.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [selfWeak.tableView endUpdates];
    };
    @weakObj(cell);
    cellInfo.cellUpdateValuesForKeysWithDictionary = ^(NSDictionary<NSString *,id> *keyedValues) {
        [keyedValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [cellWeak setValue:obj forKeyPath:key];
        }];
    };
    cell.cellInfo = cellInfo;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AMTableViewCellInfo * cellInfo = [self cellInfoForIndexPath:indexPath];
    if(cellInfo.cellHeight){
        return cellInfo.cellHeight;
    }
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMTableViewCellInfo * cellInfo = [self cellInfoForIndexPath:indexPath];
    if (cellInfo.cellEvent) {
        @weakObj(cellInfo);
        cellInfo.cellEvent(cellInfoWeak);
    }
}
#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    return self.dznEmptyInfo.dznTitle;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    return self.dznEmptyInfo.dznDescription;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//    return self.dznEmptyInfo.dznButtonTitle;
    NSString *text = @"网络不给力，请点击重试哦~";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, text.length)];
    // 设置指定4个字体为蓝色
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(7, 4)];
    return attStr;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.dznEmptyInfo.dznBackgroundColor;
}

#pragma mark - DZNEmptyDataSetDelegate
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (self.dznEmptyInfo.dznButtonEvent) {
        self.dznEmptyInfo.dznButtonEvent();
    }
}
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView{
    self.tableView.contentOffset = CGPointZero;
    if (self.tableView.mj_footer.isHidden == NO) {
        self.tableView.mj_footer.hidden = YES;
    }
}
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView{
    if (self.tableView.mj_footer.isHidden == YES) {
        self.tableView.mj_footer.hidden = NO;
    }
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (void)reloadData{
    
    if(strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0){
        [self.tableView reloadData];
    }else{
        @weakObj(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [selfWeak.tableView reloadData];
        });
    }
}
    

@end
