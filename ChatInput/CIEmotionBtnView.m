
//
//  EmotionBtnView.m
//  ChatInput
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIEmotionBtnView.h"

@implementation CIEmotionBtnView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (IBAction)didChooseEmotion:(id)sender {
    [self.emotionBtnDelegate didChooseEmotion:self index:self.tag - 10];
}

@end
