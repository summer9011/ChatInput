//
//  EmotionListBtnView.h
//  ChatInput
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CIEmotionListBtnView;

@protocol EmotionListBtnDelegate <NSObject>

- (void)didSelectEmotionListBtnView:(CIEmotionListBtnView *)listBtnView;

@end

@interface CIEmotionListBtnView : UIView

@property (nonatomic, weak) id<EmotionListBtnDelegate> listBtnDelegate;

@property (weak, nonatomic) IBOutlet UIImageView *btnImageView;
@property (weak, nonatomic) IBOutlet UIButton *listBtn;

@end
