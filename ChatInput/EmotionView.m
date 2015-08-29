//
//  EmotionView.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "EmotionView.h"

@interface EmotionView () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *emotionContentScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *emotionListScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *sendEmotionBtn;

@end

@implementation EmotionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.isShow = NO;
    
    self.emotionContentScrollView.delegate = self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.emotionContentScrollView]) {
        
    }
}

@end
