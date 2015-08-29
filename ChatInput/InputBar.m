//
//  InputBar.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "InputBar.h"

@interface InputBar ()

@property (weak, nonatomic) IBOutlet UIButton *inputModeBtn;
@property (weak, nonatomic) IBOutlet UIButton *anotherBtn;
@property (weak, nonatomic) IBOutlet UIButton *emotionBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation InputBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (IBAction)changeMode:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if ([button isEqual:self.inputModeBtn]) {
        if (button.selected) {
            button.selected = NO;
            
            [self.inputDelegate inputBar:self didSelectedMode:InputTextMode];
        } else {
            button.selected = YES;
            
            [self.inputDelegate inputBar:self didSelectedMode:InputVoiceMode];
        }
        
    } else if ([button isEqual:self.emotionBtn]) {
        if (button.selected) {
            button.selected = NO;
            
            [self.inputDelegate inputBar:self didUnSelectedMode:InputEmotionMode];
        } else {
            button.selected = YES;
            
            [self.inputDelegate inputBar:self didSelectedMode:InputEmotionMode];
        }
        
    } else if ([button isEqual:self.anotherBtn]) {
        if (button.selected) {
            button.selected = NO;
            
            [self.inputDelegate inputBar:self didUnSelectedMode:InputAnotherMode];
        } else {
            button.selected = YES;
            
            [self.inputDelegate inputBar:self didSelectedMode:InputAnotherMode];
        }
    }
}

@end
