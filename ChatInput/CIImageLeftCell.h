//
//  CIImageLeftCell.h
//  ChatInput
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIImageLeftCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageViewConstraintWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageViewConstraintHeight;

@end
