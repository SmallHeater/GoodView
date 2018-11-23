//
//  JHStoreSearchBar.m
//  JHLivePlayDemo
//
//  Created by xianjunwang on 2017/8/3.
//  Copyright © 2017年 pk. All rights reserved.
//

#import "SHSearchBar.h"

@implementation SHSearchBar
#pragma mark  ----  生命周期函数
-(instancetype)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeHolder{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSAttributedString * placeString = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:Color_C4C4C4}];
        self.attributedPlaceholder = placeString;
        //图片距离左边14
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search.tiff"]];
        searchIcon.frame = CGRectMake(4, (frame.size.height - 14) / 2, 14, 14);
        
        
        UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 22, frame.size.height)];
        [leftView addSubview:searchIcon];
        
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 22, 4);
}




@end
