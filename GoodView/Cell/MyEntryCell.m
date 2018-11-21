//
//  MyEntryCell.m
//  GoodView
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 mac. All rights reserved.
//  高度40

#import "MyEntryCell.h"

@interface MyEntryCell ()

//图标
@property (nonatomic,strong) UIImageView * iconImageView;
//标题
@property (nonatomic,strong) UILabel * titleLabel;
//内容
@property (nonatomic,strong) UILabel * contentLabel;


@end

@implementation MyEntryCell

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
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}


-(void)setImage:(NSString *)imageName andTitle:(NSString *)title andContent:(NSString *)content{
    
}

#pragma mark  ----  懒加载
-(UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
    }
    return _contentLabel;
}

@end
