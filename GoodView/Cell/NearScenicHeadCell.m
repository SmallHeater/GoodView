//
//  NearScenicHeadCell.m
//  GoodView
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 mac. All rights reserved.
//

#import "NearScenicHeadCell.h"


@interface NearScenicHeadCell ()

@property (nonatomic,strong) UIImageView * myImageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@end


@implementation NearScenicHeadCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
    }
    return self;
}


#pragma mark  ----  自定义函数
-(void)setUI{
    
    [self addSubview:self.myImageView];
    [self.myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(10);
        make.top.offset(12);
        make.width.height.offset(26);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(50);
        make.top.offset(10);
        make.width.offset(100);
        make.height.offset(30);
    }];

    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset(-1);
        make.height.offset(1);
    }];
}



#pragma mark  ----  懒加载

-(UIImageView *)myImageView{
    
    if (!_myImageView) {
        
        _myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uu@2x.png"]];
    }
    return _myImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"附近景区";
    }
    return _titleLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_F5F5F5;
    }
    return _lineLabel;
}


@end
