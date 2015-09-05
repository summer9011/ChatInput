//
//  InputBar.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIInputBar.h"
#import "CIConstants.h"

@interface CIInputBar () <UITextViewDelegate>

@end

@implementation CIInputBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.textView.delegate = self;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.layer.borderColor = BackgroundColor.CGColor;
    self.textView.layer.borderWidth = 0.5;
    
    self.voiceBtn.layer.masksToBounds = YES;
    self.voiceBtn.layer.cornerRadius = 5.f;
    self.voiceBtn.layer.borderColor = BackgroundColor.CGColor;
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
    [button setBackgroundColor:InputBarNormalBackgroundColor];
    
    [self.inputDelegate didStartVoice];
}

- (IBAction)voiceUp:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:InputBarHightlightBackgroundColor];
    
    [self.inputDelegate didFinishVoice];
}

- (IBAction)voiceDragOutside:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setBackgroundColor:InputBarHightlightBackgroundColor];
    
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

- (void)setText:(NSString *)text {
    // 获得光标所在的位置
    NSUInteger location = self.textView.selectedRange.location;
    
    // 将UITextView中的内容进行调整（主要是在光标所在的位置进行字符串截取，再拼接你需要插入的文字即可）
    NSString *content = self.textView.text;
    NSString *result = [NSString stringWithFormat:@"%@%@%@", [content substringToIndex:location], text, [content substringFromIndex:location]];
    
    // 将调整后的字符串添加到UITextView上面
    self.textView.text = result;
    
    [self.textView layoutIfNeeded];
    [self textViewDidChange:self.textView];
    
    [self.inputDelegate textView:YES];
}

- (void)deleteText {
    if (![self.textView.text isEqualToString:@""]) {
        NSString *pattern = @"\\[[a-zA-Z0-9\u4e00-\u9fa5]+\\]";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *resultArr = [regex matchesInString:self.textView.text options:NSMatchingReportProgress range:NSMakeRange(0, self.textView.text.length)];
        
        NSRange range;
        
        if (resultArr.count > 0) {
            NSTextCheckingResult *result = resultArr.lastObject;
            range = NSMakeRange(0, result.range.location);
        } else {
            range = NSMakeRange(0, self.textView.text.length - 1);
        }
        
        self.textView.text = [self.textView.text substringWithRange:range];
        [self.textView layoutIfNeeded];
        
        [self textViewDidChange:self.textView];
    } else {
        [self.inputDelegate textView:NO];
    }
}

- (void)sendMessage {
    [self.inputDelegate didSendMessage:self.textView.text];
    self.textView.text = nil;
    
    [self resetViewHeight:CIInputBarHeight];
}

#pragma mark - Private Method

- (void)resetViewHeight:(CGFloat)height {
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            if (constraint.constant != height) {
                constraint.constant = height;
                
                [UIView animateWithDuration:0.3 animations:^{
                    [self layoutIfNeeded];
                }];
                
                [self.textView setContentOffset:CGPointZero animated:YES];
                
                [self.inputDelegate willChangeTextViewHeight:height];
            }
            
            break;
        }
    }
    
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
    
    if ([textView.text isEqualToString:@""]) {
        [self.inputDelegate textView:NO];
    } else {
        [self.inputDelegate textView:YES];
    }
}

@end
