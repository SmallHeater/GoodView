//
//  VerticalLoopView.h
//  CrowdFund
//
//  Created by yin.pj on 16/3/25.
//  Copyright © 2016年 sk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VerticalLoopDelegate<NSObject>

- (void)didClickContentAtIndex:(NSInteger)index;

@end
typedef enum
{
    VerticalLoopDirectionBottom,
    VerticalLoopDirectionDown,
    
}VerticalLoopDirection;

@interface VerticalLoopView : UIView
{
    
    // 创建两个label循环滚动
    UILabel *_firstContentLabel;
    UILabel *_secondContentLabel;
    // 记录
    int currentIndex;

}

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) int is_start;
/** 动画方向默认往上
 *  跑马灯动画时间
 */
@property(nonatomic) float verticalLoopAnimationDuration;
/**
 *  显示的内容(支持多条数据)
 */
@property(nonatomic, retain) NSArray *verticalLoopContentArr;
/**
 * loop方向(上下/右)
 */
@property(nonatomic) VerticalLoopDirection Direction;
@property (nonatomic)id<VerticalLoopDelegate> loopDelegate;
/**
 *  开启
 */
-(void)start;
-(void)stop;

@end
