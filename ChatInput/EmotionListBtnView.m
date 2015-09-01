//
//  EmotionListBtnView.m
//  ChatInput
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "EmotionListBtnView.h"
#import "Constants.h"

@implementation EmotionListBtnView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (IBAction)selectedListBtnView:(id)sender {
    [self.listBtnDelegate didSelectEmotionListBtnView:self];
}

@end
