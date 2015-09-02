//
//  MessageRightCell.h
//  ChatInput
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIMessageRightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailBtnConstraintWidth;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *sendingActivity;
@property (weak, nonatomic) IBOutlet UIButton *resendBtn;

@end
