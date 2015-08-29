//
//  AnotherView.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AnotherView.h"
#import "AnotherContentView.h"

@interface AnotherView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation AnotherView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.isShow = NO;
    
    self.scrollView.delegate = self;
}

- (void)addItems:(NSArray *)items row:(NSUInteger)row col:(NSUInteger)col {
    CGFloat page = ceilf(items.count/(CGFloat)(row * col));
    
    self.pageControl.numberOfPages = page;
    self.pageControl.currentPage = 0;
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth) {
            self.viewWidth = constraint.constant;
        }
        
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            self.viewHeight = constraint.constant;
        }
    }
    
    CGFloat itemWidth = (self.viewWidth - 16 * 2) / (CGFloat)col;
    CGFloat itemHeight = (self.viewHeight - 30) / (CGFloat)row;
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth * page, self.viewHeight);
    
    int i = 0;
    for (NSDictionary *item in items) {
        NSUInteger perOffsetX = i%col;
        NSUInteger perOffsetY = i/col;
        NSUInteger pageLocation = i/(col * row);
        
        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"AnotherContentView" owner:@"AnotherContentView" options:nil];
        AnotherContentView *itemView = nibViews[0];
        itemView.tag = i+1;
        
        [self.scrollView addSubview:itemView];
        
        itemView.contentLabel.text = item[@"title"];
        itemView.contentImageView.image = [UIImage imageNamed:item[@"imageName"]];
        
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:itemWidth];
        
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:itemHeight];
        
        [itemView addConstraints:@[width, height]];
        
        NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1.f constant:16 + pageLocation * self.viewWidth + perOffsetX * itemWidth];
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:itemView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.f constant: 16 + (perOffsetY - pageLocation * row) * itemHeight];
        
        [self.scrollView addConstraints:@[leading, top]];
        
        //增加触摸事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didChooseItem:)];
        [itemView addGestureRecognizer:singleTap];
        
        i ++;
    }
    
    [self bringSubviewToFront:self.pageControl];
}

#pragma mark - GestureRecognizer

- (void)didChooseItem:(UITapGestureRecognizer *)recognizer {
    UIView *itemView = recognizer.view;
    NSUInteger index = itemView.tag - 1;
    
    [self.anotherViewDelegate didChooseItem:index];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentPage = roundf(scrollView.contentOffset.x/self.viewWidth);
    
    self.pageControl.currentPage = currentPage;
}

@end
