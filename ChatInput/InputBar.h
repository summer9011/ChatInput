//
//  InputBar.h
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputBar;

typedef NS_ENUM(NSUInteger, InputMode){
    InputTextMode,
    InputVoiceMode,
    InputEmotionMode,
    InputAnotherMode
};

@protocol InputBarDelegate <NSObject>

- (void)didSendMessage:(NSString *)message;

- (void)didChooseTextField;

- (void)didStartVoice;

- (void)didEndVoice;

- (void)inputBar:(InputBar *)inputBar didSelectedMode:(InputMode)inputMode;

- (void)inputBar:(InputBar *)inputBar didUnSelectedMode:(InputMode)inputMode;

@end

@interface InputBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *inputModeBtn;
@property (weak, nonatomic) IBOutlet UIButton *anotherBtn;
@property (weak, nonatomic) IBOutlet UIButton *emotionBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@property (nonatomic, weak) id<InputBarDelegate> inputDelegate;

- (void)beginEditing;

- (void)endEditing;

- (void)showVoiceInput;

- (void)hideVoiceInput;

@end
