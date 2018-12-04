//
//  AMViewController.m
//  AMTableViewInfo
//
//  Created by 83076130@qq.com on 11/14/2018.
//  Copyright (c) 2018 83076130@qq.com. All rights reserved.
//

#import "AMViewController.h"
//#import <AMTableViewInfo/AMTableViewInfo-umbrella.h>

@interface AMViewController ()<AMTableViewInfoDelegate>
@property (nonatomic, strong) AMTableViewInfo * tbInfo;
@end

@implementation AMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tbInfo = [[AMTableViewInfo alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 200) style:UITableViewStylePlain];
    [self.view addSubview:self.tbInfo.tableView];
    // MARK: 设置 MJRefresh 代理,mj_header 和 mj_footer 是根据是否实现了相应的刷新代理方法才会显示的
    self.tbInfo.delegate = self;
    // MARK: 配置空视图和空视图点击事件
    self.tbInfo.dznEmptyInfo = [AMDZNEmptyInfo new];
    __weak typeof(self) selfWeak = self;
    self.tbInfo.dznEmptyInfo.dznButtonEvent = ^{
        AMTableViewCellInfo * cellInfo = [AMTableViewCellInfo new]; // 初始化 cell 模型类,可继承该类进行扩展自定义 cell;
        //    cellInfo.cellCreateType = AMTableviewCellCreateTypeNib;   // cell 的创建方式;
        cellInfo.cellStyle = UITableViewCellStyleValue1;    // 系统 cell 样式;
        cellInfo.text = @"text";   // textLabel 的 text
        cellInfo.detailText = @"detailText"; // detailTextLable 的 text
        cellInfo.cellEvent = ^(AMTableViewCellInfo * cellInfo) {    // cell 的点击事件
            NSLog(@"点击了cell: text = %@, detailText = %@",cellInfo.text, cellInfo.detailText);
        };
        cellInfo.cellHeight = 40;   // 未设置 cell 高度时候为自动高度,需设置好 cell 约束条件;
        [selfWeak.tbInfo addCellInfo:cellInfo forSectionIndex:0];   // 添加 cell 数据源;
        [selfWeak.tbInfo reloadData];   // 异步刷新显示 cell;
    };
}
- (AMTableViewCellInfo *)genarateCellInfoWithText:(NSString *)text detailText:(NSString *)detailText{
    AMTableViewCellInfo * cellInfo = [AMTableViewCellInfo new];
    if (detailText == nil) {
        NSDate * date = [NSDate date];
        NSDateFormatter * formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"HH:mm:ss"];
        NSString * dateStr = [formatter stringFromDate:date];
        detailText = [NSString stringWithFormat:@"创建时间: %@",dateStr];
    }
    cellInfo.detailText = detailText;
    cellInfo.cellStyle = UITableViewCellStyleValue1;
    cellInfo.text = text;
    cellInfo.cellEvent = ^(AMTableViewCellInfo * cellInfo) {
        NSLog(@"点击了cell: text = %@, detailText = %@",cellInfo.text, cellInfo.detailText);
    };
    return cellInfo;
}

//- (void)requestDataNeedReset:(BOOL)reset{
//    __weak typeof(self) selfWeak = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // MARK: 模拟数据请求成功,下一步将数据添加到 tabinfo 中并刷新;
//        NSString * text;
//        if (selfWeak.tbInfo.tableView.tableHeaderView.bounds.size.height > 10) {//
//            <#statements#>
//        }
//
//        [selfWeak.tbInfo endMJRefreshForRequestFailure];
//        AMTableViewCellInfo * cellInfo = [selfWeak genarateCellInfoWithText:@"下拉刷新" detailText:nil];
//        [selfWeak.tbInfo addCellInfo:cellInfo forSectionIndex:0];
//        [selfWeak.tbInfo reloadData];
//    });
//}

#pragma mark - AMTableViewDelegate
- (void)pullDownNewData{
    static NSInteger flag = 0;
    __weak typeof(self) selfWeak = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (flag % 2 == 0) {
            [selfWeak.tbInfo endMJRefreshIfHasNextPage:NO];
        }else{
            [selfWeak.tbInfo endMJRefreshForRequestFailure];
        }
        flag ++;
        
        [selfWeak.tbInfo.sectionsArr removeAllObjects];
        AMTableViewCellInfo * cellInfo = [selfWeak genarateCellInfoWithText:@"下拉刷新" detailText:nil];
        [selfWeak.tbInfo addCellInfo:cellInfo forSectionIndex:0];
        [selfWeak.tbInfo reloadData];
    });
}
- (BOOL)pullUpMoreData{
    AMTableViewSectionInfo * sectionInfo = self.tbInfo.sectionsArr[0];
    if (sectionInfo.cellsArr.count > 9) {// 没有更多数据了,不再请求
        return NO;
    }
    __weak typeof(self) selfWeak = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [selfWeak.tbInfo endMJRefreshIfHasNextPage:YES];
        AMTableViewCellInfo * cellInfo = [selfWeak genarateCellInfoWithText:@"上拉加载" detailText:nil];
        [selfWeak.tbInfo addCellInfo:cellInfo forSectionIndex:0];   // 添加 cell 数据源;
        [selfWeak.tbInfo reloadData];
    });
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
