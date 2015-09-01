//
//  EmotionBtnView.h
//  ChatInput
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CIEmotionBtnView;

@protocol EmotionBtnDelegate <NSObject>

- (void)didChooseEmotion:(CIEmotionBtnView *)emtionBtnView index:(NSUInteger)index;

@end

@interface CIEmotionBtnView : UIView

@property (nonatomic, weak) id<EmotionBtnDelegate> emotionBtnDelegate;

@property (weak, nonatomic) IBOutlet UIImageView *emotionImageView;
@property (weak, nonatomic) IBOutlet UIButton *emtionBtn;

@end
