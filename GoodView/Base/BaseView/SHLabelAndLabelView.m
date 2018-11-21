//
//  LabelAndLabelView.m
//  JHLivePlayLibrary
//
//  Created by xianjunwang on 2018/4/26.
//  Copyright © 2018年 pk. All rights reserved.
//

#import "SHLabelAndLabelView.h"

@interface SHLabelAndLabelView (){
    
    BOOL hadAddFirstLabel;
    BOOL hadAddSecondLabel;
}

//上面的label
@property (nonatomic,strong) UILabel * firstLabel;
//下面的label
@property (nonatomic,strong) UILabel * secondLabel;

@end


@implementation SHLabelAndLabelView

#pragma mark  ----  生命周期函数

-(instancetype)initWithFrame:(CGRect)frame andFirstLabelFrame:(CGRect)firstLabelFrame andSecondLabelFrame:(CGRect)secondLabelFrame andFirstLabelText:(NSString *)firstLabelText andSecondLabelText:(NSString *)secondLabelText{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        if (firstLabelText) {
            
            self.firstLabel.frame = firstLabelFrame;
            self.firstLabel.text = firstLabelText;
            [self addSubview:self.firstLabel];
            hadAddFirstLabel = YES;
        }
        else{
            
            hadAddFirstLabel = NO;
        }
        
        
        if (secondLabelText) {
            
            self.secondLabel.frame = secondLabelFrame;
            self.secondLabel.text = secondLabelText;
            [self addSubview:self.secondLabel];
            hadAddSecondLabel = YES;
        }
        else{
            
            hadAddSecondLabel = NO;
        }
    }
    return self;
}

#pragma mark  ----  自定义函数
-(void)refreshFirstLabelText:(NSString *)firstLabelText secondLabelText:(NSString *)secondLabelText{
    
    if (firstLabelText) {
        
        self.firstLabel.text = firstLabelText;
        
        if (!hadAddFirstLabel) {
            
            [self addSubview:self.firstLabel];
        }
    }
    
    if (secondLabelText) {
        
        self.secondLabel.text = secondLabelText;
        
        if (!hadAddSecondLabel) {
            
            [self addSubview:self.secondLabel];
        }
    }
}

-(void)refreshFirstLabelFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    
    if (font) {
        
        self.firstLabel.font = font;
    }
    
    if (textColor) {
        
        self.firstLabel.textColor = textColor;
    }
    
    if (textAlignment) {
        
        self.firstLabel.textAlignment = textAlignment;
    }
}

-(void)refreshSecondLabelFont:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    
    if (font) {
        
        self.secondLabel.font = font;
    }
    
    if (textColor) {
        
        self.secondLabel.textColor = textColor;
    }
    
    if (textAlignment) {
        
        self.secondLabel.textAlignment = textAlignment;
    }
}

-(void)firstLabelAddTarget:(id)target andAction:(SEL)action{
    
    if (target && action) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self.firstLabel addGestureRecognizer:tap];
        self.firstLabel.userInteractionEnabled = YES;
    }
}

-(void)secondLabelAddTarget:(id)target andAction:(SEL)action{
    
    if (target && action) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self.secondLabel addGestureRecognizer:tap];
        self.secondLabel.userInteractionEnabled = YES;
    }
}

#pragma mark  ----  懒加载
-(UILabel *)firstLabel{
    
    if (!_firstLabel) {
        
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.font = [UIFont systemFontOfSize:15];
        _firstLabel.textColor = [UIColor blackColor];
    }
    return _firstLabel;
}

-(UILabel *)secondLabel{
    
    if (!_secondLabel) {
        
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.font = [UIFont systemFontOfSize:14];
        _secondLabel.textColor = [UIColor blackColor];
    }
    return _secondLabel;
}

@end
