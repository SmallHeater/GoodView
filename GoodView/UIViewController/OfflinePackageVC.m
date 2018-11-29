//
//  OfflinePackageVC.m
//  GoodView
//
//  Created by mac on 2018/11/25.
//  Copyright © 2018 mac. All rights reserved.
//

#import "OfflinePackageVC.h"

@interface OfflinePackageVC ()

//编辑按钮
@property (nonatomic,strong) UIButton * editBtn;
//底部全选，删除view
@property (nonatomic,strong) UIView * bottomView;

@end

@implementation OfflinePackageVC

#pragma mark  ----  生命周期函数

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self.busNavigationBar addSubview:self.editBtn];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.offset(20);
        make.right.offset(-10);
        make.height.offset(44);
        make.width.offset(60);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.offset(0);
        make.height.offset(50);
    }];
}
//编辑按钮的响应
-(void)editBtnClicked:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.offset(-50);
        }];
        self.bottomView.hidden = NO;
    }
    else{
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.offset(0);
        }];
        self.bottomView.hidden = YES;
    }
}

//全选按钮的响应
-(void)selectedBtnClicked{
    
}

//删除按钮的响应
-(void)deleteBtnClicked{
    
}


#pragma mark  ----  懒加载
-(UIButton *)editBtn{
    
    if (!_editBtn) {
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitle:@"取消" forState:UIControlStateSelected];
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        
        _bottomView = [[UIView alloc] init];
        _bottomView.hidden = YES;
        CALayer * topLayer = [CALayer layer];
        topLayer.backgroundColor = Color_F5F5F5.CGColor;
        topLayer.frame = CGRectMake(0, 0, MAINWIDTH, 1);
        [_bottomView.layer addSublayer:topLayer];
        
        //全选按钮
        UIButton * selectedAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectedAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [selectedAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [selectedAllBtn addTarget:self action:@selector(selectedBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:selectedAllBtn];
        [selectedAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.top.bottom.offset(0);
            make.width.offset(100);
        }];
        
        //删除
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.top.bottom.offset(0);
            make.width.offset(100);
        }];
    }
    return _bottomView;
}

@end
