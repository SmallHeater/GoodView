//
//  ImageAndTitleBtn.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/21.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "SHImageAndTitleBtn.h"

@interface SHImageAndTitleBtn ()

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,copy) NSString * selectedImageName;

@end

@implementation SHImageAndTitleBtn

#pragma mark  ----  生命周期函数
-(instancetype)initWithFrame:(CGRect)frame andImageFrame:(CGRect)imageFrame andTitleFrame:(CGRect)titleFrame andImageName:(NSString *)imageName andSelectedImageName:(NSString *)selectedImageName andTitle:(NSString *)title andTarget:(id)target andAction:(SEL)action{
    
    self = [super initWithFrame:frame];
    if (self) {
    
        self.imageView.image = [UIImage imageNamed:imageName];
        self.imageView.frame = imageFrame;
        self.titleLabel.frame = titleFrame;
        self.titleLabel.text = title;
        
        self.imageName = imageName;
        self.selectedImageName = selectedImageName;
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        
        if (target && action) {
            
            [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

#pragma mark  ----  自定义函数
//刷新文字和色值
-(void)refreshTitle:(NSString *)title color:(UIColor *)textColor{
    
    if (title) {
        
        self.titleLabel.text = title;
    }
    
    if (textColor) {
        
        self.titleLabel.textColor = textColor;
    }
}

#pragma mark  ---- SET
-(void)setSelected:(BOOL)selected{
    
    super.selected = selected;
    if (selected) {
        
        self.imageView.image = [UIImage imageNamed:self.selectedImageName];
    }
    else{
        
        self.imageView.image = [UIImage imageNamed:self.imageName];
    }
}

#pragma mark  ----  懒加载
-(UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
