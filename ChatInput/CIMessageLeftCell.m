//
//  MessageLeftCell.m
//  ChatInput
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIMessageLeftCell.h"

@implementation CIMessageLeftCell

- (void)awakeFromNib {
    // Initialization code
    
    UIImage *image = [UIImage imageNamed:@"ReceiverTextNodeBkg"];
    UIImage *resizeImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 12, 8, 8) resizingMode:UIImageResizingModeStretch];
    self.detailBackground.image = resizeImage;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnAvatar:)];
    [self.iconImageView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnDetail:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.detailView addGestureRecognizer:doubleTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapOnAvatar:(UITapGestureRecognizer *)recognizer {
    NSLog(@"tapOnAvatar");
}

- (void)tapOnDetail:(UITapGestureRecognizer *)recognizer {
    NSLog(@"tapOnDetail");
}

@end
