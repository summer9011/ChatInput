//
//  TimeCell.h
//  ChatInput
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CITimeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeLabelConstraintWidth;

@end
