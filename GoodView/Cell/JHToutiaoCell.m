//
//  JHToutiaoCell.m
//  GoodView
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 mac. All rights reserved.
//

#import "JHToutiaoCell.h"
#import "VerticalLoopView.h"
#import "JHArticle.h"
#import "WKWebViewController.h"


@interface JHToutiaoCell ()<VerticalLoopDelegate>

//景好头条
@property (nonatomic,strong) UIView * headlineView;
@property (nonatomic,strong) VerticalLoopView * verticalLoopV;
//景好头条模型数组
@property (nonatomic,strong) NSMutableArray<JHArticle *> * dataArray;


@end

@implementation JHToutiaoCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
    }
    return self;
}

#pragma mark  ----  代理
#pragma mark  ----  VerticalLoopDelegate
- (void)didClickContentAtIndex:(NSInteger)index{
    
    if (self.dataArray.count > index) {
     
        JHArticle *article =  self.dataArray[index];
        WKWebViewController * controller = [[WKWebViewController alloc] initWithTitle:article.title andURLStr:[NSString stringWithFormat:KGENURL@"Load/Html_article?article_id=%@",article.article_id]];
        [[self viewController].navigationController pushViewController:controller animated:NO];
    }
}


#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self addSubview:self.headlineView];
    [self.headlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.offset(0);
        make.height.offset(40);
    }];
}

//设置头数据
-(void)setToutiaoData:(NSMutableArray<JHArticle *> *)array{
    
    if (array.count > 0) {
     
        [self.verticalLoopV stop];
        self.verticalLoopV.verticalLoopContentArr = nil;
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        self.verticalLoopV.verticalLoopContentArr = self.dataArray;
        [self.verticalLoopV start];
    }
}


#pragma mark  ----  懒加载
-(VerticalLoopView *)verticalLoopV{
    
    if (!_verticalLoopV) {
        
        _verticalLoopV = [[VerticalLoopView alloc] initWithFrame:CGRectZero];
        _verticalLoopV.loopDelegate = self;
        _verticalLoopV.is_start = 1;
        _verticalLoopV.backgroundColor = [UIColor whiteColor];
        _verticalLoopV.verticalLoopAnimationDuration = 1;
        _verticalLoopV.Direction = VerticalLoopDirectionDown;
    }
    return _verticalLoopV;
}

-(UIView *)headlineView{
    
    if (!_headlineView) {
        
        _headlineView = [[UIView alloc] init];
        _headlineView.backgroundColor = [UIColor grayColor];
        
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headline@2x.jpg"]];
        imageView.backgroundColor = [UIColor greenColor];
        [_headlineView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.bottom.offset(0);
            make.width.offset(100);
        }];
        
        CALayer * rightLayer = [CALayer layer];
        rightLayer.frame = CGRectMake(99, 0, 1, 39);
        rightLayer.backgroundColor = Color_F5F5F5.CGColor;
        [imageView.layer addSublayer:rightLayer];
        
        
        [_headlineView addSubview:self.verticalLoopV];
        [self.verticalLoopV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(imageView.mas_right).offset(0);
            make.top.right.bottom.offset(0);
        }];
        
        CALayer * bottomLayer = [CALayer layer];
        bottomLayer.frame = CGRectMake(0, 39, MAINWIDTH, 1);
        bottomLayer.backgroundColor = Color_F5F5F5.CGColor;
        [_headlineView.layer addSublayer:bottomLayer];
    }
    return _headlineView;
}

-(NSMutableArray<JHArticle *> *)dataArray{
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
