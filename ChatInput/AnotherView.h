//
//  AnotherView.h
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnotherViewDelegate <NSObject>

- (void)didChooseItem:(NSUInteger)index;

@end

@interface AnotherView : UIView

@property (nonatomic, weak) id<AnotherViewDelegate> anotherViewDelegate;

/**
 *  View是否显示
 */
@property (nonatomic, assign) BOOL isShow;

/**
 *  AnotherView中添加内容
 *  @param row 行
 *  @param col 列
 */
- (void)addItems:(NSArray *)items row:(NSUInteger)row col:(NSUInteger)col;

@end
