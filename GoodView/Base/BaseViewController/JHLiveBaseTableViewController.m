//
//  JHLiveBaseTableViewController.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/19.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "JHLiveBaseTableViewController.h"
#import "JHLiveBaseNavigationBar.h"
#import "JHLiveAdaptUI.h"
#import "JHLivePlayRemindView.h"
#import "JHLiveBaseRequest.h"
#import "UIColor+Translate.h"


#define INTERNETERROR @"您的网络好像不太给力，稍后重试"

@interface JHLiveBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>



@end

@implementation JHLiveBaseTableViewController

#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

#pragma mark  ----  自定义函数
-(void)backBtnClicked:(UIButton *)btn{
    
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count == 1) {
            
            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)requestListData{
    
}

-(void)refreshViewWithViewType:(TBVCViewType)viewType{
    
    if (viewType != TBVCReloadData) {
        
        [self.tableView removeFromSuperview];
        [self.noDataView removeFromSuperview];
        [self.noInternetBGView removeFromSuperview];
    }
    
    switch (viewType) {
            
        case TBVCDefault:
            
            break;
        case TBVCTableView:
        {
            
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
        }
            break;
        case TBVCReloadData:
        {
            
            [self.tableView reloadData];
        }
            break;
        case TBVCNoInternet:
        {
            
            //无网络
            [[JHLivePlayRemindView shareRemindView] showInView:self.noInternetBGView   imageName:@"JHLivePlayBundle.bundle/NoInternetNew.tiff" remindTxt:INTERNETERROR withBtnBlock:^{
                if ([JHLiveBaseRequest isNetWorkActivity]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.viewType = TBVCDefault;
                    });
                    [self requestListData];
                }
            } ];
            [self.view addSubview:self.noInternetBGView];
        }
            break;
        case TBVCNoData:
        {
            
            [self.view addSubview:self.noDataView];
        }
            break;
        default:
            break;
    }
}



#pragma mark  ----  SET
-(void)setViewType:(TBVCViewType)viewType{
    
    _viewType = viewType;
    
    if (viewType != TBVCReloadData && viewType != TBVCDefault) {
        
        [self.tableView removeFromSuperview];
        [self.noDataView removeFromSuperview];
        [self.noInternetBGView removeFromSuperview];
    }
    
    switch (viewType) {
            
        case TBVCDefault:
            
            break;
        case TBVCTableView:
        {
            
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
        }
            break;
        case TBVCReloadData:
        {
            
            [self.tableView reloadData];
        }
            break;
        case TBVCNoInternet:
        {
            
            //无网络
            [[JHLivePlayRemindView shareRemindView] showInView:self.noInternetBGView   imageName:@"JHLivePlayBundle.bundle/NoInternetNew.tiff" remindTxt:INTERNETERROR withBtnBlock:^{
                if ([JHLiveBaseRequest isNetWorkActivity]) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.viewType = TBVCDefault;
                    });
                    [self requestListData];
                }
            } ];
            [self.view addSubview:self.noInternetBGView];
        }
            break;
        case TBVCNoData:
        {
            
            [self.view addSubview:self.noDataView];
        }
            break;
        default:
            break;
    }
}
#pragma mark  ----  懒加载

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [JHLiveAdaptUI heightOfNavigationBar], MAINWIDTH, MAINHEIGHT - [JHLiveAdaptUI heightOfNavigationBar] - [JHLiveAdaptUI heightOfEmptyBottom]) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor colorFromHexRGB:@"F5F5F5"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
