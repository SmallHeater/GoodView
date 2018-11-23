//
//  JHBusinessNavigationBar.m
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/9/7.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "JHLiveBaseNavigationBar.h"
#import "JHLiveAdaptUI.h"



#define NAVWIDTH  300
@interface JHLiveBaseNavigationBar ()
//标题label
@property (nonatomic,strong) UILabel * titleLabel;

//分割线label
@property (nonatomic,strong) UILabel * lineLabel;

@end

@implementation JHLiveBaseNavigationBar

#pragma mark  ----  生命周期函数
-(instancetype)initWithTitle:(NSString *)title andBackbtnAction:(SEL)action andBackBtnTarget:(id)target{
    self = [super initWithFrame:CGRectMake(0, 0, MAINWIDTH, 64 + [JHLiveAdaptUI heightOfLiuHai])];
    if (self) {
        
        self.backgroundColor = Color_87BA4B;
        [self addSubview:self.titleLabel];
        
        self.navTitle = title;
        
        if (target) {
            [self.backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.backBtn];
        }
    }
    return self;
}


#pragma mark  ----  SET
-(void)setNavTitle:(NSString *)navTitle{

    _navTitle = navTitle;
    if (navTitle && navTitle.length > 0) {
        
        self.titleLabel.text = navTitle;
    }
}

#pragma mark  ----  懒加载

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20 + [JHLiveAdaptUI heightOfLiuHai], MAINWIDTH - 120, 44)];
        _titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}


-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setFrame:CGRectMake(0, 20 + [JHLiveAdaptUI heightOfLiuHai], 60, 44)];
        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 27);
        [_backBtn setImage:[UIImage imageNamed:@"JHLiveCommonImages.bundle/back.tiff"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        
        _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1)];
        _lineLabel.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    }
    return _lineLabel;
}
@end
