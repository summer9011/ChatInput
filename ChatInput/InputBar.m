//
//  InputBar.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "InputBar.h"
#import "Constants.h"

@interface InputBar () <UITextViewDelegate>

@end

@implementation InputBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.textView.delegate = self;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.layer.borderColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1.f].CGColor;
    self.textView.layer.borderWidth = 0.5;
    
    self.voiceBtn.layer.masksToBounds = YES;
    self.voiceBtn.layer.cornerRadius = 5.f;
    self.voiceBtn.layer.borderColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1.f].CGColor;
    self.voiceBtn.layer.borderWidth = 0.5;
}

#pragma mark - IBAction

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
            
            [self textViewDidChange:self.textView];
            
            [self.inputDelegate inputBar:self didSelectedMode:InputTextMode];
        } else {
            button.selected = YES;
            
            self.voiceBtn.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                self.voiceBtn.alpha = 1.f;
            }];
            
            [self resetViewHeight:CIInputBarHeight];
            
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
    [self.textView becomeFirstResponder];
}

- (void)endEditing {
    [self.textView resignFirstResponder];
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

#pragma mark - Private Method

- (void)resetViewHeight:(CGFloat)height {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = height;
            break;
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
    
    [self.textView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.inputDelegate didChooseTextView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [self.inputDelegate didSendMessage:textView.text];
        textView.text = nil;
        
        [self resetViewHeight:CIInputBarHeight];
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    CGFloat height = CIInputBarHeight - CIInputTextViewHeight + textView.contentSize.height;
    [self resetViewHeight:height];
    
    NSLog(@"frame %@, contentSize %@", NSStringFromCGSize(self.textView.frame.size), NSStringFromCGSize(self.textView.contentSize));
}

@end
