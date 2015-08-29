//
//  InputBar.h
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputBar;

typedef enum : NSUInteger{
    InputTextMode,
    InputVoiceMode,
    InputEmotionMode,
    InputAnotherMode
}InputMode;

@protocol InputBarDelegate <NSObject>

- (void)inputBar:(InputBar *)inputBar didSelectedMode:(InputMode)inputMode;

- (void)inputBar:(InputBar *)inputBar didUnSelectedMode:(InputMode)inputMode;

@end

@interface InputBar : UIView

@property (nonatomic, weak) id<InputBarDelegate> inputDelegate;

@end
