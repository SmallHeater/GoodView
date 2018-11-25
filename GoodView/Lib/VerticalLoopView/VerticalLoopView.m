//
//  VerticalLoopView.m
//  CrowdFund
//
//  Created by yin.pj on 16/3/25.
//  Copyright © 2016年 sk. All rights reserved.
//

#import "VerticalLoopView.h"
#import "JHArticle.h"

@implementation VerticalLoopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
    }
    return self;
}


-(void)setupView {
    
    
    _firstContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height)];
    [_firstContentLabel setBackgroundColor:[UIColor clearColor]];
    [_firstContentLabel setNumberOfLines:1];
    _firstContentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturRecongnizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer1.numberOfTapsRequired = 1;
    [_firstContentLabel addGestureRecognizer:tapGesturRecongnizer1];
    
    _firstContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_firstContentLabel setTextColor:[UIColor blackColor]];
    _firstContentLabel.font=[UIFont boldSystemFontOfSize:15.f];

    
    _secondContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height , self.frame.size.width - 20, self.frame.size.height)];
    [_secondContentLabel setBackgroundColor:[UIColor clearColor]];
    [_secondContentLabel setTextColor:[UIColor blackColor]];
    _secondContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [_secondContentLabel setNumberOfLines:1];
    _secondContentLabel.userInteractionEnabled = YES;
     _secondContentLabel.font=[UIFont boldSystemFontOfSize:15.f];
    
    
    UITapGestureRecognizer *tapGesturRecongnizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopContentClick)];
    tapGesturRecongnizer2.numberOfTapsRequired = 1;
    [_secondContentLabel addGestureRecognizer:tapGesturRecongnizer2];

    
    [self addSubview:_firstContentLabel];
    [self addSubview:_secondContentLabel];
    
    // 默认初始方向是向上
    _Direction = VerticalLoopDirectionDown;
    _verticalLoopAnimationDuration = 1;
    self.clipsToBounds = YES;
    
}



-(void)startVerticalLoopAnimation{
    
    
      JHArticle *article = [_verticalLoopContentArr objectAtIndex:currentIndex];
    
    _firstContentLabel.text = article.title;

    float firstContentLaStartY = 0;
    float firstContentLaEndY = 0;
    float secondContentLaStartY = 0;
    float secondContentLaEndY = 0;
    
    int secondCurrentIndex  = currentIndex + 1;
    if (secondCurrentIndex > _verticalLoopContentArr.count - 1) {
        secondCurrentIndex = 0;
    }
    
    switch (_Direction) {
        case VerticalLoopDirectionBottom:
        
            firstContentLaStartY = 0;
            firstContentLaEndY = self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY - self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY - self.frame.size.height;
            
            break;
        case VerticalLoopDirectionDown:
            
            firstContentLaStartY = 0;
            firstContentLaEndY = -self.frame.size.height;
            
            secondContentLaStartY = firstContentLaStartY + self.frame.size.height;
            secondContentLaEndY = firstContentLaEndY + self.frame.size.height;
            
            break;
        default:
            break;
    }
    
    JHArticle *article2 = [_verticalLoopContentArr objectAtIndex:secondCurrentIndex];
    
    _secondContentLabel.text = article2.title;
    
    _firstContentLabel.frame = CGRectMake(10, firstContentLaStartY, self.frame.size.width - 20, self.frame.size.height);
    _secondContentLabel.frame = CGRectMake(10, secondContentLaStartY, self.frame.size.width - 20, self.frame.size.height);
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:_verticalLoopAnimationDuration];
    [UIView setAnimationDelay:1];
    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(verticalLoopAnimationDidStop:finished:context:)];
    CGRect firstContentLabelFrame = _firstContentLabel.frame;
    firstContentLabelFrame.origin.y = firstContentLaEndY;
    
    [_firstContentLabel setFrame:firstContentLabelFrame];
    [_secondContentLabel setFrame:CGRectMake(10,secondContentLaEndY, self.frame.size.width - 20, self.frame.size.height)];
    [UIView commitAnimations];
    
}

-(void)verticalLoopAnimationDidStop
{
    
    currentIndex++;
    if(currentIndex >= [_verticalLoopContentArr count]) {
        currentIndex = 0;
    }
    if(_is_start == 1){
         [self startVerticalLoopAnimation];
    }
   
    
}
- (void)loopContentClick
{
    if ([self.loopDelegate respondsToSelector:@selector(didClickContentAtIndex:)]) {
        [self.loopDelegate didClickContentAtIndex:currentIndex];
    }
}
#pragma mark - verticalLoop Animation Handling
-(void)start {
    
    // 开启动画默认第一条信息
    currentIndex = 0;
    // 开始动画
    
    _timer= [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(verticalLoopAnimationDidStop) userInfo:nil repeats:YES];
    [self startVerticalLoopAnimation];
}

-(void)stop{
    
    [_timer invalidate];  // 从运行循环中移除， 对运行循环的引用进行一次 release
    _timer=nil;
}


-(void)dealloc{
    NSLog(@"dealloc:%@",[self class]);
}
@end
