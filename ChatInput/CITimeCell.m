//
//  TimeCell.m
//  ChatInput
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CITimeCell.h"

@implementation CITimeCell

- (void)awakeFromNib {
    // Initialization code
    
    self.timeLabel.layer.masksToBounds = YES;
    self.timeLabel.layer.cornerRadius = 5.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
