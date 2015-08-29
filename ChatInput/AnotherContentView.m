//
//  AnotherContentView.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AnotherContentView.h"

@interface AnotherContentView ()

@end

@implementation AnotherContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentImageView.layer.masksToBounds = YES;
    self.contentImageView.layer.cornerRadius = 5.f;
    self.contentImageView.layer.borderColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1.f].CGColor;
    self.contentImageView.layer.borderWidth = 0.5;
}

@end
