//
//  CIEmotionAlertView.h
//  ChatInput
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIEmotionAlertView : UIView

/**
 *  显示表情弹出层
 *  @param image 表情图片
 *  @param emotionKey 表情文字
 */
- (void)showEmotionAlertIn:(UIView *)parentView image:(UIImage *)image emotionKey:(NSString *)emotionKey;

/**
 *  隐藏表情弹出层
 */
- (void)hidden;

@end
