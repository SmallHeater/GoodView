//
//  JHToutiaoCell.h
//  GoodView
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018 mac. All rights reserved.
//  景好头条cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JHArticle;

@interface JHToutiaoCell : UITableViewCell

//设置头数据
-(void)setToutiaoData:(NSMutableArray<JHArticle *> *)array;

@end

NS_ASSUME_NONNULL_END
