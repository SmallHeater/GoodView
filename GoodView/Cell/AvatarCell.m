//
//  AvatarCell.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "AvatarCell.h"

@interface AvatarCell ()

//标题
@property (nonatomic,strong) UILabel * titleLabel;
//头像
@property (nonatomic,strong) UIImageView * avatarImageView;

@end

@implementation AvatarCell

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
    [self addSubview:self.avatarImageView];
   
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(5);
        make.top.offset(5);
        make.bottom.offset(-5);
        make.width.offset(120);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(5);
        make.right.offset(-30);
        make.bottom.offset(-5);
        make.width.equalTo(self.avatarImageView.mas_height).multipliedBy(1.0f);
    }];
    
    [self layoutIfNeeded];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = CGRectGetWidth(self.avatarImageView.frame)/2;
}


-(void)setTitle:(NSString *)title andImage:(NSString *)imageName{
    
    self.avatarImageView.image = nil;
    self.titleLabel.text = @"";

    if (title) {

        self.titleLabel.text = title;
    }

    if (imageName) {
        
        self.avatarImageView.image = [UIImage imageNamed:imageName];
    }
}

#pragma mark  ----  懒加载
-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

-(UIImageView *)avatarImageView{
    
    if (!_avatarImageView) {
        
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor redColor];
    }
    return _avatarImageView;
}

@end
