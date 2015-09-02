//
//  CIEmotionAlertView.m
//  ChatInput
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIEmotionAlertView.h"
#import "CIConstants.h"

@interface CIEmotionAlertView ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bigEmotionImageView;
@property (weak, nonatomic) IBOutlet UILabel *emotionKeyLabel;

@end

@implementation CIEmotionAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.f;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = BackgroundColor.CGColor;
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)showEmotionAlertIn:(UIView *)parentView image:(UIImage *)image emotionKey:(NSString *)emotionKey {
    self.hidden = NO;
    
    self.bigEmotionImageView.image = image;
    self.emotionKeyLabel.text = [emotionKey substringWithRange:NSMakeRange(1, emotionKey.length - 2)];
    
    if (![parentView.subviews containsObject:parentView]) {
        [parentView addSubview:self];
    }
}

- (void)hidden {
    self.hidden = YES;
}

@end
