//
//  CIEmotionAlertView.m
//  ChatInput
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIEmotionAlertView.h"

@interface CIEmotionAlertView ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bigEmotionImageView;
@property (weak, nonatomic) IBOutlet UILabel *emotionKeyLabel;

@end

@implementation CIEmotionAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)showEmotionAlertIn:(UIView *)parentView image:(UIImage *)image emotionKey:(NSString *)emotionKey {
    self.bigEmotionImageView.image = image;
    self.emotionKeyLabel.text = emotionKey;
    
    if (![parentView.subviews containsObject:parentView]) {
        [parentView addSubview:self];
    }
}

- (void)hidden {
    [self removeFromSuperview];
}

@end
