//
//  JHLiveBaseTableViewController.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/19.
//  Copyright © 2018年 pk. All rights reserved.
//  tableViewController基类

#import "JHLiveBaseViewController.h"


typedef NS_ENUM(NSUInteger,TBVCViewType){
    
    TBVCDefault = 0,//默认状态，只有导航
    TBVCTableView,//显示tableView
    TBVCReloadData,//刷新数据
    TBVCNoInternet,//无网
    TBVCNoData//无数据
};

typedef NS_ENUM(NSUInteger,TBVCDataType){
    
    TBVCGetNewData = 0,
    TBVCLoadMoreData
};


@interface JHLiveBaseTableViewController : JHLiveBaseViewController


//页面view，type(本类会做处理)
@property (nonatomic,assign) TBVCViewType viewType;
//子页面view的type（子页面自己做处理）
@property (nonatomic,assign) TBVCViewType childViewType;
@property (nonatomic,assign) TBVCDataType dataType;

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArray;



//返回
- (void)backBtnClicked:(UIButton *)btn;
//请求列表数据
-(void)requestListData;
//刷新页面展示
-(void)refreshViewWithViewType:(TBVCViewType)viewType;
@end
