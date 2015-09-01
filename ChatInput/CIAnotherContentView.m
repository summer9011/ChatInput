//
//  AnotherContentView.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIAnotherContentView.h"
#import "CIConstants.h"

@interface CIAnotherContentView ()

@end

@implementation CIAnotherContentView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentImageView.layer.masksToBounds = YES;
    self.contentImageView.layer.cornerRadius = 5.f;
    self.contentImageView.layer.borderColor = BackgroundColor.CGColor;
    self.contentImageView.layer.borderWidth = 0.5;
}

@end
