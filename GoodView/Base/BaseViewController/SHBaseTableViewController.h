//
//  JHLiveBaseTableViewController.h
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/19.
//  Copyright © 2018年 pk. All rights reserved.
//  tableViewController基类

#import "SHBaseViewController.h"


@interface SHBaseTableViewController : SHBaseViewController


@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

-(instancetype)initWithTitle:(NSString *)navTitle andTableViewStyle:(UITableViewStyle)style;

@end
