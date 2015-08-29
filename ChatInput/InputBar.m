//
//  InputBar.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "InputBar.h"

@interface InputBar () <UITextFieldDelegate>

@end

@implementation InputBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.textField.delegate = self;
    
    self.voiceBtn.layer.masksToBounds = YES;
    self.voiceBtn.layer.cornerRadius = 5.f;
    self.voiceBtn.layer.borderColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1.f].CGColor;
    self.voiceBtn.layer.borderWidth = 0.5;
}

- (IBAction)changeMode:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    if ([button isEqual:self.inputModeBtn]) {
        if (button.selected) {
            button.selected = NO;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.voiceBtn.alpha = 0.f;
            } completion:^(BOOL finished) {
                self.voiceBtn.hidden = YES;
            }];
            
            [self.inputDelegate inputBar:self didSelectedMode:InputTextMode];
        } else {
            button.selected = YES;
            
            self.voiceBtn.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.voiceBtn.alpha = 1.f;
            }];
            
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

- (IBAction)voiceDown:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor colorWithRed:220/255.f green:220/255.f blue:220/255.f alpha:1.f]];
    
    [self.inputDelegate didStartVoice];
}

- (IBAction)voiceUp:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1.f]];
    
    [self.inputDelegate didFinishVoice];
}

- (IBAction)voiceDragOutside:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:[UIColor colorWithRed:248/255.f green:248/255.f blue:248/255.f alpha:1.f]];
    
    [self.inputDelegate willCancelVoice];
}

- (IBAction)voiceUpOutside:(id)sender {
    [self.inputDelegate didCancelledVoice];
}

#pragma mark - Public Method

- (void)beginEditing {
    [self.textField becomeFirstResponder];
}

- (void)endEditing {
    [self.textField resignFirstResponder];
}

- (void)showVoiceInput {
    self.inputModeBtn.selected = YES;
    
    self.voiceBtn.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.voiceBtn.alpha = 1.f;
    }];
}

- (void)hideVoiceInput {
    self.inputModeBtn.selected = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.voiceBtn.alpha = 0.f;
    } completion:^(BOOL finished) {
        self.voiceBtn.hidden = YES;
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.inputDelegate didChooseTextField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.inputDelegate didSendMessage:textField.text];
    textField.text = nil;
    
    return YES;
}

@end
