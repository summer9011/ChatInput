//
//  EmotionView.h
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmotionViewDelegate <NSObject>

/**
 *  选中了某个表情
 *  @param 表情分类的下标
 *  @param 表情详情的下标
 */
- (void)didChooseEmotion:(NSUInteger)typeIndex contentIndex:(NSUInteger)contentIndex;

@end

@interface EmotionView : UIView

@property (nonatomic, weak) id<EmotionViewDelegate> emotionViewDelegate;

/**
 *  View是否显示
 */
@property (nonatomic, assign) BOOL isShow;

/**
 *  添加表情
 *  @param items 表情列表数据
 */
- (void)addItems:(NSArray *)items;

@end
