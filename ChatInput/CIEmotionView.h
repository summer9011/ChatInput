//
//  EmotionView.h
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EmotionType){
    EmotionExpressionType,
    EmotionCustomType
};

@protocol EmotionViewDelegate <NSObject>

/**
 *  选中了某个表情
 *  @param emotionKey 表情的下标
 *  @param emotionType 表情类型
 */
- (void)didChoosedEmotion:(NSString *)emotionKey type:(EmotionType)emotionType;

/**
 *  删除最后一个图标
 */
- (void)didDeleteEmotion;

/**
 *  发送文字消息
 */
- (void)didEmotionSendMessage;

@end

@interface CIEmotionView : UIView

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

/**
 *  设置表情发送按钮
 *  @param isEnable 是否可发送
 */
- (void)emotionSendBtnEnable:(BOOL)isEnable;

@end
