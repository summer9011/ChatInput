//
//  EmotionView.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "EmotionView.h"

@interface EmotionView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;

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
    
    self.sendEmotionBtn.layer.masksToBounds = YES;
    self.sendEmotionBtn.layer.cornerRadius = 5.f;
    self.sendEmotionBtn.layer.borderColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1.f].CGColor;
    self.sendEmotionBtn.layer.borderWidth = 0.5;
    
    self.emotionListScrollView.contentSize = CGSizeMake(1000, 20);
}

#pragma mark - Public Method

- (void)addItems:(NSArray *)items {
    CGFloat listScrollViewWidth = 0.0;
    CGFloat listScrollViewHeight = 0.0;
    
    for (NSLayoutConstraint *constraint in self.emotionListScrollView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            listScrollViewWidth = constraint.constant;
        }
        
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            listScrollViewHeight = constraint.constant;
        }
    }
    
    self.emotionListScrollView.contentSize = CGSizeMake(listScrollViewWidth * items.count, listScrollViewHeight);
    
    //后台执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        int i = 0;
        for (NSDictionary *item in items) {
            NSString *title = item[@"title"];
            if ([title isEqualToString:@"expression"]) {
                CGFloat width = 35.f;
                CGFloat height = 35.f;
                
                //同步主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = i + 1;
                    [button setImage:[UIImage imageNamed:item[@"imageName"]] forState:UIControlStateNormal];
                    button.adjustsImageWhenHighlighted = NO;
                    button.translatesAutoresizingMaskIntoConstraints = NO;
                    [button addTarget:self action:@selector(chooseEmotionType:) forControlEvents:UIControlEventTouchUpInside];
                    [self.emotionListScrollView addSubview:button];
                    
                    NSLayoutConstraint *widthCons = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:width];
                    
                    NSLayoutConstraint *heightCons = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:height];
                    
                    [button addConstraints:@[widthCons, heightCons]];
                    
                    NSLayoutConstraint *leadingCons = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.emotionListScrollView attribute:NSLayoutAttributeLeading multiplier:1.f constant:i * width];
                    
                    NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.emotionListScrollView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
                    
                    [self.emotionListScrollView addConstraints:@[leadingCons, topCons]];
                });
                
                NSString *resourcePath = [[NSBundle mainBundle] pathForResource:item[@"title"] ofType:@"plist"];
                NSDictionary *expressionDic = [[NSDictionary alloc] initWithContentsOfFile:resourcePath];
                
                NSUInteger col = 8;
                NSUInteger row = 3;
                
                CGFloat page = ceilf(expressionDic.count/(CGFloat)(row * col));
                
                for (NSLayoutConstraint *constraint in self.constraints) {
                    if (constraint.firstAttribute == NSLayoutAttributeWidth) {
                        self.viewWidth = constraint.constant;
                    }
                    
                    if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                        self.viewHeight = constraint.constant;
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.pageControl.numberOfPages = page;
                    self.pageControl.currentPage = 0;
                    
                    self.emotionContentScrollView.contentSize = CGSizeMake(self.viewWidth * page, self.viewHeight - 35);
                });
                
                int j = 0;
                for (NSString *expressionStr in expressionDic) {
                    NSString *expressionPath = expressionDic[expressionStr];
                    
                    j ++;
                }
                
            } else {
                
            }
            
            i ++;
        }
    });
}

#pragma mark - Button Action

- (void)chooseEmotionType:(UIButton *)button {
    NSUInteger typeIndex = button.tag - 1;
    
    NSLog(@"%ld", typeIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.emotionContentScrollView]) {
        CGFloat currentPage = roundf(scrollView.contentOffset.x/self.viewWidth);
        
        self.pageControl.currentPage = currentPage;
    }
}

@end
