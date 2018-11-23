//
//  ScenicSpotCell.m
//  GoodView
//
//  Created by xianjunwang on 2018/11/23.
//  Copyright © 2018年 mac. All rights reserved.
//  高100

#import "ScenicSpotCell.h"

@interface ScenicSpotCell ()

@property (nonatomic,strong) UIImageView * myImageView;
@property (nonatomic,strong) UILabel * nameLabel;
@property (nonatomic,strong) UILabel * contentLabel;
//听图片
@property (nonatomic,strong) UIImageView * listenImageView;
@property (nonatomic,strong) UILabel * listenLabel;
@property (nonatomic,strong) UIImageView * locationImageView;
@property (nonatomic,strong) UILabel * locationLabel;
@property (nonatomic,strong) UILabel * bottomLineLabel;
@end

@implementation ScenicSpotCell

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
       
        make.left.top.offset(8);
        make.bottom.offset(-8);
        make.width.equalTo(self.myImageView.mas_height).multipliedBy(1.0f);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.myImageView.mas_right).offset(5);
        make.top.offset(12);
        make.right.offset(-5);
        make.height.offset(16);
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLabel.mas_left).offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.right.equalTo(self.nameLabel.mas_right);
        make.height.offset(15);
    }];
    
    [self addSubview:self.listenImageView];
    [self.listenImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.nameLabel.mas_left).offset(0);
        make.bottom.equalTo(self.myImageView.mas_bottom).offset(-5);
        make.width.height.offset(15);
    }];
    
    [self addSubview:self.listenLabel];
    [self.listenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.listenImageView.mas_right).offset(5);
        make.height.offset(15);
        make.width.offset(100);
        make.bottom.equalTo(self.listenImageView.mas_bottom).offset(0);
    }];
    
    [self addSubview:self.locationImageView];
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-80);
        make.bottom.equalTo(self.myImageView.mas_bottom).offset(0);
        make.width.height.offset(20);
    }];
    
    [self addSubview:self.locationLabel];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.locationImageView.mas_right).offset(5);
        make.right.offset(-5);
        make.height.offset(15);
        make.bottom.equalTo(self.locationImageView.mas_bottom).offset(-3);
    }];
    
    [self addSubview:self.bottomLineLabel];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.offset(0);
        make.bottom.offset(-1);
        make.height.offset(1);
    }];
}


#pragma mark  ---- 懒加载
-(UIImageView *)myImageView{
    
    if (!_myImageView) {
        
        _myImageView = [[UIImageView alloc] init];
        _myImageView.backgroundColor = [UIColor redColor];
        _myImageView.layer.cornerRadius = 8;
    }
    return _myImageView;
}

-(UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT16;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"太湖";
    }
    return _nameLabel;
}

-(UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.font = FONT14;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.text = @"太湖是个好地方";
    }
    return _contentLabel;
}

-(UIImageView *)listenImageView{
    
    if (!_listenImageView) {
        
        //15*15
        _listenImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_near_scenic_earphone@2x.png"]];
    }
    return _listenImageView;
}

-(UILabel *)listenLabel{
    
    if (!_listenLabel) {
        
        _listenLabel = [[UILabel alloc] init];
        _listenLabel.textColor = [UIColor grayColor];
        _listenLabel.font = FONT14;
        _listenLabel.text = @"344";
    }
    return _listenLabel;
}

-(UIImageView *)locationImageView{
    
    if (!_locationImageView) {
        
        //30*30
        _locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uu@2x.png"]];
    }
    return _locationImageView;
}

-(UILabel *)locationLabel{
    
    if (!_locationLabel) {
        
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = FONT14;
        _locationLabel.textColor = [UIColor grayColor];
        _locationLabel.text = @"123.0KM";
    }
    return _locationLabel;
}

-(UILabel *)bottomLineLabel{
    
    if (!_bottomLineLabel) {
        
        _bottomLineLabel = [[UILabel alloc] init];
        _bottomLineLabel.backgroundColor = Color_F5F5F5;
    }
    return _bottomLineLabel;
}

@end
