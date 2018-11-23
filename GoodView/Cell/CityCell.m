//
//  CityCell.m
//  GoodView
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 mac. All rights reserved.
//  高50

#import "CityCell.h"

@interface CityCell ()

@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation CityCell

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
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.titleLabel.mas_right);
        make.bottom.offset(-1);
        make.height.offset(1);
    }];
}

-(void)setCity:(NSString *)city{
    
    self.titleLabel.text = @"";
    if (city) {
        
        self.titleLabel.text = city;
    }
}

#pragma mark  ----  懒加载
-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
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
