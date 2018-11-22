//
//  JHLiveBaseTableViewController.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/19.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "JHLiveBaseTableViewController.h"



@interface JHLiveBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) UITableViewStyle style;

@end

@implementation JHLiveBaseTableViewController

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 0;
}

#pragma mark  ----  自定义函数

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
