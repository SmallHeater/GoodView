//
//  MyEntryCell.h
//  GoodView
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 mac. All rights reserved.
//  我的条目cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyEntryCell : UITableViewCell

-(void)setIconImage:(NSString *)imageName andTitle:(NSString *)title andContent:(NSString *)content andShowLine:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
