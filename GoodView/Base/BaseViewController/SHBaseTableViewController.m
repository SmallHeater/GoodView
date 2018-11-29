//
//  JHLiveBaseTableViewController.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/19.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "SHBaseTableViewController.h"



@interface SHBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) UITableViewStyle style;

@end

@implementation SHBaseTableViewController

#pragma mark  ----  生命周期函数
-(instancetype)initWithTitle:(NSString *)navTitle andTableViewStyle:(UITableViewStyle)style{
    
    self = [super initWithTitle:navTitle];
    if (self) {
        
        self.style = style;
        [self.view addSubview:self.tableView];
    }
    return self;
}


#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

#pragma mark  ----  自定义函数
//下拉刷新触发
-(void)loadNewData{
    
}

#pragma mark  ----  懒加载

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [JHLiveAdaptUI heightOfNavigationBar], MAINWIDTH, MAINHEIGHT - [JHLiveAdaptUI heightOfNavigationBar] - [JHLiveAdaptUI heightOfEmptyBottom]) style:self.style];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (self.style == UITableViewStyleGrouped) {
            
            _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 0.01)];
        }
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        //取消contentSize和contentOffset的改的，解决闪屏问题
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        __weak SHBaseTableViewController * wkSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            [wkSelf loadNewData];
        }];
        [_tableView.mj_header beginRefreshing];
        
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
