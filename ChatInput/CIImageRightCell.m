//
//  CIImageRightCell.m
//  ChatInput
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIImageRightCell.h"

@implementation CIImageRightCell

- (void)awakeFromNib {
    // Initialization code
    
    self.contentImageView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnAvatar:)];
    [self.iconImageView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnDetail:)];
    [self.contentImageView addGestureRecognizer:singleTap2];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imageWidth = self.contentImageViewConstraintWidth.constant;
    CGFloat imageHeight = self.contentImageViewConstraintHeight.constant;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(imageWidth, 20)];
    [path addLineToPoint:CGPointMake(imageWidth - 6, 24)];
    [path addLineToPoint:CGPointMake(imageWidth - 6, imageHeight - 12)];
    [path addArcWithCenter:CGPointMake(imageWidth - 12, imageHeight - 12) radius:6.f startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(12, imageHeight - 6)];
    [path addArcWithCenter:CGPointMake(12, imageHeight - 12) radius:6.f startAngle:M_PI_2 endAngle:M_PI_2 * 2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(6, 12)];
    [path addArcWithCenter:CGPointMake(12, 12) radius:6.f startAngle:-2 * M_PI_2 endAngle:-1 * M_PI_2 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(imageWidth - 12, 6)];
    [path addArcWithCenter:CGPointMake(imageWidth - 12, 12) radius:6.f startAngle:-1 * M_PI_2 endAngle:0 clockwise:YES];
    
    [path addLineToPoint:CGPointMake(imageWidth - 6, 16)];
    
    [path closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    
    self.contentImageView.layer.mask = shapeLayer;
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
