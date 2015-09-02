//
//  EmotionView.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIEmotionView.h"

#import "CIEmotionListBtnView.h"
#import "CIEmotionBtnView.h"
#import "CIEmotionAlertView.h"

#import "CIConstants.h"

@interface CIEmotionView () <UIScrollViewDelegate, CIEmotionListBtnDelegate, CIEmotionBtnDelegate>

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, assign) NSUInteger currentTypeIndex;
@property (nonatomic, strong) NSArray *items;

@property (weak, nonatomic) IBOutlet UIScrollView *emotionContentScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *emotionListScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *sendEmotionBtn;

@property (nonatomic, strong) CIEmotionAlertView *emotionAlertView;

@property (nonatomic, strong) NSLayoutConstraint *emotionAlertLeading;
@property (nonatomic, strong) NSLayoutConstraint *emotionAlertTop;

@property (nonatomic, strong) NSLayoutConstraint *emotionAlertWidth;
@property (nonatomic, strong) NSLayoutConstraint *emotionAlertHeight;

@property (nonatomic, strong) CIEmotionBtnView *tmpEmotionBtn;

@end

@implementation CIEmotionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.isShow = NO;
    
    self.emotionContentScrollView.delegate = self;
    
    self.emotionContentScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.emotionContentScrollView addGestureRecognizer:longPress];
    
    self.sendEmotionBtn.layer.masksToBounds = YES;
    self.sendEmotionBtn.layer.cornerRadius = 5.f;
    self.sendEmotionBtn.layer.borderColor = BackgroundColor.CGColor;
    self.sendEmotionBtn.layer.borderWidth = 0.5;
    self.sendEmotionBtn.enabled = NO;
}

#pragma mark - GestureRecognizer 

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
    CGPoint locationPoint = [recognizer locationInView:self.emotionContentScrollView];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            if (self.emotionAlertView == nil) {
                NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CIEmotionAlertView" owner:@"CIEmotionAlertView" options:nil];
                self.emotionAlertView = nibViews[0];
                [self.emotionContentScrollView addSubview:self.emotionAlertView];
                
                self.emotionAlertWidth = [NSLayoutConstraint constraintWithItem:self.emotionAlertView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:46.f];
                self.emotionAlertHeight = [NSLayoutConstraint constraintWithItem:self.emotionAlertView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:86.f];
                
                [self.emotionAlertView addConstraints:@[self.emotionAlertWidth, self.emotionAlertHeight]];
                
                self.emotionAlertLeading = [NSLayoutConstraint constraintWithItem:self.emotionAlertView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.emotionContentScrollView attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
                self.emotionAlertTop = [NSLayoutConstraint constraintWithItem:self.emotionAlertView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.emotionContentScrollView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
                
                [self.emotionContentScrollView addConstraints:@[self.emotionAlertLeading, self.emotionAlertTop]];
            }
            
            for (CIEmotionBtnView *view in self.emotionContentScrollView.subviews) {
                if (CGRectContainsPoint(view.frame, locationPoint)) {
                    if (view.emotionKey != nil) {
                        self.emotionAlertLeading.constant = view.frame.origin.x + (CGRectGetWidth(view.frame) - self.emotionAlertWidth.constant)/2.f;
                        self.emotionAlertTop.constant = view.frame.origin.y + CGRectGetHeight(view.frame) - self.emotionAlertHeight.constant - 10;
                        [self layoutIfNeeded];
                        
                        [self.emotionAlertView showEmotionAlertIn:self.emotionContentScrollView image:view.emotionImageView.image emotionKey:view.emotionKey];
                    } else {
                        [self.emotionAlertView hidden];
                    }
                    
                    self.tmpEmotionBtn = view;
                    
                    break;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            for (CIEmotionBtnView *view in self.emotionContentScrollView.subviews) {
                if (CGRectContainsPoint(view.frame, locationPoint)) {
                    if (view.emotionKey != nil) {
                        self.emotionAlertLeading.constant = view.frame.origin.x + (CGRectGetWidth(view.frame) - self.emotionAlertWidth.constant)/2.f;
                        self.emotionAlertTop.constant = view.frame.origin.y + CGRectGetHeight(view.frame) - self.emotionAlertHeight.constant - 10;
                        [self layoutIfNeeded];
                        
                        [self.emotionAlertView showEmotionAlertIn:self.emotionContentScrollView image:view.emotionImageView.image emotionKey:view.emotionKey];
                    } else {
                        [self.emotionAlertView hidden];
                    }
                    
                    self.tmpEmotionBtn = view;
                    
                    break;
                }
            }
        }
            break;
        default: {
            [self.emotionAlertView hidden];
            
            [self didChooseEmotion:self.tmpEmotionBtn index:0];
            self.tmpEmotionBtn = nil;
        }
            break;
    }
}

#pragma mark - Public Method

- (void)addItems:(NSArray *)items {
    self.items = items;
    
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
            
            CGFloat width = 35.f;
            CGFloat height = 35.f;
            
            //同步主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CIEmotionListBtnView" owner:@"CIEmotionListBtnView" options:nil];
                
                CIEmotionListBtnView *listBtn = nibViews[0];
                listBtn.tag = i + 1;
                listBtn.btnImageView.image = [UIImage imageNamed:item[@"imageName"]];
                listBtn.listBtnDelegate = self;
                [self.emotionListScrollView addSubview:listBtn];
                
                NSLayoutConstraint *widthCons = [NSLayoutConstraint constraintWithItem:listBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:width];
                
                NSLayoutConstraint *heightCons = [NSLayoutConstraint constraintWithItem:listBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:height];
                
                [listBtn addConstraints:@[widthCons, heightCons]];
                
                NSLayoutConstraint *leadingCons = [NSLayoutConstraint constraintWithItem:listBtn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.emotionListScrollView attribute:NSLayoutAttributeLeading multiplier:1.f constant:i * width];
                
                NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:listBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.emotionListScrollView attribute:NSLayoutAttributeTop multiplier:1.f constant:0.f];
                
                [self.emotionListScrollView addConstraints:@[leadingCons, topCons]];
                
                [self didSelectEmotionListBtnView:listBtn];
            });
            
            if ([title isEqualToString:@"expression"]) {
                //表情详情
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
                
                CGFloat contentWidth = (self.viewWidth - 30)/col;
                CGFloat contentHeight = (self.viewHeight - 35 - 10 - 20)/row;
                
                NSUInteger j = 1;
                for (NSUInteger tag = 1; tag <= expressionDic.count + page; tag ++) {
                    NSUInteger perOffsetX = (tag - 1)%col;
                    NSUInteger perOffsetY = (tag - 1)/col;
                    NSUInteger pageLocation = (tag - 1)/(col * row);
                    
                    NSString *expressionPath = [NSString stringWithFormat:@"Expression_%ld@2x.png", j];
                    
                    //获取到表情的Key
                    NSString *emotionKeyStr;
                    for (NSString *emotionKey in expressionDic) {
                        if ([expressionDic[emotionKey] isEqualToString:expressionPath]) {
                            emotionKeyStr = emotionKey;
                            break;
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CIEmotionBtnView" owner:@"CIEmotionBtnView" options:nil];
                        CIEmotionBtnView *emotionBtn = nibViews[0];
                        emotionBtn.tag = tag + 10;
                        emotionBtn.emotionBtnDelegate = self;
                        
                        if (tag%(col * row) == 0 || tag == (expressionDic.count + page)) {
                            emotionBtn.emotionKey = nil;
                            emotionBtn.emotionImageView.image = [UIImage imageNamed:@"DeleteEmoticonBtn"];
                        } else {
                            emotionBtn.emotionKey = emotionKeyStr;
                            emotionBtn.emotionImageView.image = [UIImage imageNamed:expressionPath];
                        }
                        
                        [self.emotionContentScrollView addSubview:emotionBtn];
                        
                        NSLayoutConstraint *widthCons = [NSLayoutConstraint constraintWithItem:emotionBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:contentWidth];
                        
                        NSLayoutConstraint *heightCons = [NSLayoutConstraint constraintWithItem:emotionBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:contentHeight];
                        
                        [emotionBtn addConstraints:@[widthCons, heightCons]];
                        
                        NSLayoutConstraint *leadingCons = [NSLayoutConstraint constraintWithItem:emotionBtn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.emotionContentScrollView attribute:NSLayoutAttributeLeading multiplier:1.f constant:15 + pageLocation * self.viewWidth + perOffsetX * contentWidth];
                        
                        NSLayoutConstraint *topCons = [NSLayoutConstraint constraintWithItem:emotionBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.emotionContentScrollView attribute:NSLayoutAttributeTop multiplier:1.f constant:10 + (perOffsetY - pageLocation * row) * contentHeight];
                        
                        [self.emotionContentScrollView addConstraints:@[leadingCons, topCons]];
                    });
                    
                    if (tag%(col * row) != 0) {
                        j ++;
                    }
                }
            } else {
                
            }
            
            i ++;
        }
    });
}

- (void)emotionSendBtnEnable:(BOOL)isEnable {
    if (isEnable) {
        self.sendEmotionBtn.enabled = YES;
        
        [self.sendEmotionBtn setTitleColor:InputBarHightlightBackgroundColor forState:UIControlStateNormal];
        self.sendEmotionBtn.backgroundColor = [UIColor colorWithRed:0.f green:122/255.f blue:1.f alpha:1.f];
    } else {
        self.sendEmotionBtn.enabled = NO;
        
        [self.sendEmotionBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.sendEmotionBtn.backgroundColor = InputBarHightlightBackgroundColor;
    }
}

#pragma mark - IBAction

- (IBAction)clickOnSendBtn:(id)sender {
    [self.emotionViewDelegate didEmotionSendMessage];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.emotionContentScrollView]) {
        CGFloat currentPage = roundf(scrollView.contentOffset.x/self.viewWidth);
        
        self.pageControl.currentPage = currentPage;
    }
}

#pragma mark - CIEmotionListBtnDelegate

- (void)didSelectEmotionListBtnView:(CIEmotionListBtnView *)listBtnView {
    for (CIEmotionListBtnView *tmpListBtnView in self.emotionListScrollView.subviews) {
        if (![tmpListBtnView isEqual:listBtnView]) {
            tmpListBtnView.backgroundColor = InputBarHightlightBackgroundColor;
        }
    }
    
    listBtnView.backgroundColor = EmotionViewBackgroundColor;
    
    NSUInteger typeIndex = listBtnView.tag - 1;
    self.currentTypeIndex = typeIndex;
}

#pragma mark - CIEmotionBtnDelegate

- (void)didChooseEmotion:(CIEmotionBtnView *)emtionBtnView index:(NSUInteger)index {
    if (self.currentTypeIndex == 0) {           //expression
        if (emtionBtnView.emotionKey == nil) {
            [self.emotionViewDelegate didDeleteEmotion];
        } else {
            [self.emotionViewDelegate didChoosedEmotion:emtionBtnView.emotionKey type:EmotionExpressionType];
        }
    } else {
        [self.emotionViewDelegate didChoosedEmotion:@"" type:EmotionCustomType];
    }
}

@end
