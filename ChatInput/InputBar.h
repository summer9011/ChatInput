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
    InputTextMode,              //输入文字
    InputVoiceMode,             //发送语音
    InputEmotionMode,           //发送表情
    InputAnotherMode            //发送其他内容
};

@protocol InputBarDelegate <NSObject>

/**
 *  文字编辑完成
 *  @param message 文字
 */
- (void)didSendMessage:(NSString *)message;

/**
 *  点击TextFiled
 */
- (void)didChooseTextField;

/**
 *  开始录音
 */
- (void)didStartVoice;

/**
 *  完成录音
 */
- (void)didFinishVoice;

/**
 *  将要取消录音
 */
- (void)willCancelVoice;

/**
 *  已经取消录音
 */
- (void)didCancelledVoice;

/**
 *  选择其中一个输入模式
 *  @param inputBar 当前InputBar对象
 *  @param inputMode 模式
 */
- (void)inputBar:(InputBar *)inputBar didSelectedMode:(InputMode)inputMode;

/**
 *  取消选择其中一个输入模式
 *  @param inputBar 当前InputBar对象
 *  @param inputMode 模式
 */
- (void)inputBar:(InputBar *)inputBar didUnSelectedMode:(InputMode)inputMode;

@end

@interface InputBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *inputModeBtn;
@property (weak, nonatomic) IBOutlet UIButton *anotherBtn;
@property (weak, nonatomic) IBOutlet UIButton *emotionBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@property (nonatomic, weak) id<InputBarDelegate> inputDelegate;

/**
 *  TextField becomeFirstResponder
 */
- (void)beginEditing;

/**
 *  TextField resignFirstResponder
 */
- (void)endEditing;

/**
 *  显示录音按钮
 */
- (void)showVoiceInput;

/**
 *  隐藏录音按钮
 */
- (void)hideVoiceInput;

@end
