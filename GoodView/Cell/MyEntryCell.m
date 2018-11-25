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
//分割线
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation MyEntryCell

#pragma mark  ----  生命周期函数
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


#pragma mark  ----  自定义函数

-(void)setIconImage:(NSString *)imageName andTitle:(NSString *)title andContent:(NSString *)content andShowLine:(BOOL)isShow{
    
    [self.iconImageView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
    [self.contentLabel removeFromSuperview];
    [self.lineLabel removeFromSuperview];
    
    self.iconImageView.image = nil;
    self.titleLabel.text = @"";
    self.contentLabel.text = @"";
    
    
    if (imageName && imageName.length > 0) {
        
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.offset(8);
            make.bottom.offset(-8);
            make.width.equalTo(self.iconImageView.mas_height).multipliedBy(1.0f);
        }];
        self.iconImageView.image = [UIImage imageNamed:imageName];
    }
    
    if (title && title.length > 0) {
        
        [self addSubview:self.titleLabel];
        if (imageName && imageName.length > 0){
            
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.iconImageView.mas_right).offset(10);
                make.top.offset(5);
                make.bottom.offset(-5);
                make.width.offset(120);
            }];
        }
        else{
            
            //如果没有图片，需要另设置约束
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(10);
                make.top.offset(5);
                make.bottom.offset(-5);
                make.width.offset(120);
            }];
        }
        
        self.titleLabel.text = title;
    }
    
    if (content && content.length > 0) {
        
        [self addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(5);
            make.bottom.offset(-5);
            make.right.offset(-30);
            make.width.offset(200);
        }];
        self.contentLabel.text = content;
    }
    
    if (isShow) {
        
        [self addSubview:self.lineLabel];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.offset(0);
            make.bottom.offset(-1);
            make.height.offset(1);
        }];
    }
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
        _titleLabel.font = FONT15;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = FONT13;
    }
    return _contentLabel;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = Color_F5F5F5;
    }
    return _lineLabel;
}
@end
