//
//  SearchViewController.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SearchViewController.h"
#import "SHSearchBar.h"
#import "ScenicModel.h"


@interface SearchViewController ()<UITextFieldDelegate>

//搜索输入框
@property (nonatomic,strong) SHSearchBar * searchBar;
//搜索按钮
@property (nonatomic,strong) UIButton * searchBtn;
@property (nonatomic,strong) UIView * headerView;
//历史纪律view高度
@property (nonatomic,assign) float headerHeight;


@end

@implementation SearchViewController

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.tableView.backgroundColor = Color_F5F5F5;
    [self.searchBar becomeFirstResponder];
    [self creatSearchedBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  ----  代理

#pragma mark  ----  UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    NSArray * searchRecordArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchRecordArray"];
    if (searchRecordArray && [searchRecordArray isKindOfClass:[NSArray class]]) {
        
        NSMutableArray * tempArray = [[NSMutableArray alloc] initWithArray:searchRecordArray];
        [tempArray addObject:textField.text];
        searchRecordArray = nil;
        searchRecordArray = (NSArray *)tempArray;
    }
    else{
        
        searchRecordArray = [[NSArray alloc] initWithObjects:textField.text, nil];
    }
    [[NSUserDefaults standardUserDefaults] setObject:searchRecordArray forKey:@"searchRecordArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self search:self.searchBar.text];
    return YES;
}

#pragma mark  ----  代理
#pragma mark  ----  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return self.headerHeight;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark  ----  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    
    ScenicModel * model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.scenic_name;
    
    return cell;
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.busNavigationBar addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(40);
        make.top.offset(27);
        make.right.offset(-70);
        make.height.offset(30);
    }];
    
    [self.busNavigationBar addSubview:self.searchBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(20);
        make.right.offset(-10);
        make.bottom.offset(0);
        make.width.offset(60);
    }];
}

//搜索按钮的响应
-(void)searchBtnClicked{
    
    if (![NSString contentIsNullORNil:self.searchBar.text]) {
        
        [self search:self.searchBar.text];
    }
}

//创建搜索过地方的按钮
-(void)creatSearchedBtn{
    
    NSArray * searchRecordArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchRecordArray"];
    NSUInteger index = 0;
    //行
    NSUInteger row = 0;
    CGFloat totalWidth = 10;
    for (NSUInteger i = 0; i < searchRecordArray.count; i++) {
        
        if (index > searchRecordArray.count - 1) {
            
            break;
        }
        
        for (NSUInteger j = 0; j < searchRecordArray.count; j++) {
            
            if (index > searchRecordArray.count -  1) {
                
                break;
            }
            
            NSString * title = searchRecordArray[index];
            //当前btn的宽度
            CGFloat width = [NSString textWidthWithText:title font:FONT15 inHeight:28];
            if (totalWidth + width + 10 + 12 > MAINWIDTH) {
                
                row++;
                totalWidth = 10;
                continue;
            }
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(totalWidth, 25 + row * (28 + 6), width + 12, 28);
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:Color_1FBF9A forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.titleLabel.font = FONT15;
            btn.layer.cornerRadius = 5;
            [self.headerView addSubview:btn];

            totalWidth += width + 6 + 12;
            index++;
        }
    }
    
    self.headerHeight = 25 + (row + 1) * (28 + 6);
}

//清除历史记录的响应
-(void)clearRecord{
    
    NSMutableArray * searchRecordArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchRecordArray"];
    if (searchRecordArray && [searchRecordArray isKindOfClass:[NSMutableArray class]]) {
        
        [searchRecordArray removeAllObjects];
    }
    [[NSUserDefaults standardUserDefaults] setObject:searchRecordArray forKey:@"searchRecordArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//搜索
-(void)search:(NSString *)text{
    
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:KGENURL]];
    [manager POST:@"Scenic/searchScenic" parameters:@{@"scenicName":text,@"city":[AccountManager sharedManager].selectedCity,@"user_id":@"12"} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSNumber * status = responseObject[@"status"];
        if (status.integerValue == 1) {
            
            NSDictionary * dataDic = responseObject[@"result"];
            NSArray * scenicsArray = dataDic[@"scenics"];
            
            for (NSUInteger i = 0; i < scenicsArray.count; i++) {
                
                NSDictionary * dic = scenicsArray[i];
                NSError * error;
                ScenicModel * model = [[ScenicModel alloc] initWithDictionary:dic error:&error];
                if (model) {
                    
                    [self.dataArray addObject:model];
                }
            }
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD showErrorMessage:@"请求失败，请检查网络"];
    }];
}

#pragma mark  ----  懒加载
-(SHSearchBar *)searchBar{
    
    if (!_searchBar) {
        
        _searchBar = [[SHSearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andPlaceholder:@"请输入景区或者目的地"];
        _searchBar.delegate = self;
        _searchBar.layer.cornerRadius = 4;
    }
    return _searchBar;
}
-(UIButton *)searchBtn{
    
    if (!_searchBtn) {
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.titleLabel.font = FONT16;
    }
    return _searchBtn;
}

-(UIView *)headerView{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] init];
        
        //历史记录
        UILabel * label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"历史记录";
        label.font = FONT12;
        [_headerView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.offset(10);
            make.top.offset(5);
            make.width.offset(100);
            make.height.offset(12);
        }];
        
        //清除记录
        UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearBtn setTitle:@"清除记录" forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearRecord) forControlEvents:UIControlEventTouchUpInside];
        [clearBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        clearBtn.titleLabel.font = FONT12;
        [_headerView addSubview:clearBtn];
        [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(label.mas_top);
            make.right.offset(-10);
            make.width.offset(60);
            make.height.equalTo(label.mas_height);
        }];
    }
    return _headerView;
}


@end
