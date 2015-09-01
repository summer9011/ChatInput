//
//  EmotionListBtnView.m
//  ChatInput
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIEmotionListBtnView.h"
#import "CIConstants.h"

@implementation CIEmotionListBtnView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (IBAction)selectedListBtnView:(id)sender {
    [self.listBtnDelegate didSelectEmotionListBtnView:self];
}

@end
