//
//  CIDetailController.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIDetailController.h"
#import "CIDetailCell.h"

#import "InputBar.h"
#import "EmotionView.h"
#import "AnotherView.h"

@interface CIDetailController () <InputBarDelegate, AnotherViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatDetailBottom;

@property (nonatomic, strong) InputBar *inputBar;
@property (nonatomic, strong) NSLayoutConstraint *inputBarBottom;

@property (nonatomic, strong) EmotionView *emotionView;
@property (nonatomic, strong) NSLayoutConstraint *emotionViewBottom;

@property (nonatomic, strong) AnotherView *anotherView;
@property (nonatomic, strong) NSLayoutConstraint *anotherViewBottom;
@property (nonatomic, strong) NSArray *anotherItems;

@end

static NSString *CellIdentifier = @"CIDetailCell";

@implementation CIDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.chatDetail registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    [self initInputBar];
    [self initEmotionView];
    [self initAnotherView];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init View

- (void)initInputBar {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //InputBar
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"InputBar" owner:@"InputBar" options:nil];
    self.inputBar = nibViews[0];
    self.inputBar.inputDelegate = self;
    
    [self.view addSubview:self.inputBar];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:44.f];
    [self.inputBar addConstraints:@[width, height]];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
    self.inputBarBottom = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    [self.view addConstraints:@[leading, self.inputBarBottom]];
}

- (void)initEmotionView {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //emotionView
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"EmotionView" owner:@"EmotionView" options:nil];
    self.emotionView = nibViews[0];
    
    [self.view addSubview:self.emotionView];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:258.f];
    [self.emotionView addConstraints:@[width, height]];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
    self.emotionViewBottom = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:258.f];
    [self.view addConstraints:@[leading, self.emotionViewBottom]];
}

- (void)initAnotherView {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //anotherView
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"AnotherView" owner:@"AnotherView" options:nil];
    self.anotherView = nibViews[0];
    self.anotherView.anotherViewDelegate = self;
    
    [self.view addSubview:self.anotherView];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:258.f];
    [self.anotherView addConstraints:@[width, height]];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
    self.anotherViewBottom = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:258.f];
    [self.view addConstraints:@[leading, self.anotherViewBottom]];
    
    //设置AnotherView中的内容
    self.anotherItems = @[
                          @{
                              @"title": @"照片",
                              @"imageName": @"CIAnotherContent1"
                              },
                          @{
                              @"title": @"拍摄",
                              @"imageName": @"CIAnotherContent2"
                              },
                          @{
                              @"title": @"小视频",
                              @"imageName": @"CIAnotherContent3"
                              },
                          @{
                              @"title": @"视频聊天",
                              @"imageName": @"CIAnotherContent4"
                              },
                          @{
                              @"title": @"红包",
                              @"imageName": @"CIAnotherContent1"
                              },
                          @{
                              @"title": @"转账",
                              @"imageName": @"CIAnotherContent2"
                              },
                          @{
                              @"title": @"位置",
                              @"imageName": @"CIAnotherContent3"
                              },
                          @{
                              @"title": @"收藏",
                              @"imageName": @"CIAnotherContent4"
                              },
                          @{
                              @"title": @"个人名片",
                              @"imageName": @"CIAnotherContent1"
                              },
                          @{
                              @"title": @"实时对讲机",
                              @"imageName": @"CIAnotherContent2"
                              }
                          ];
    
    //1,2; 2,4; 3,6
    [self.anotherView addItems:self.anotherItems row:2 col:4];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CIDetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CIDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.messageLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.inputBar endEditing];
    
    self.inputBarBottom.constant = 0.f;
    
    [self didChooseTextField];
    [self resetTableViewFrame:YES];
}

#pragma mark - Private Method

- (void)resetTableViewFrame:(BOOL)animation {
    self.chatDetailBottom.constant = -1 * self.inputBarBottom.constant + CGRectGetHeight(self.inputBar.frame);
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    CGFloat offsetY = self.chatDetail.contentSize.height - CGRectGetHeight(self.chatDetail.frame);
    [self.chatDetail setContentOffset:CGPointMake(0, offsetY) animated:animation];
}

#pragma mark - Notification

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.inputBarBottom.constant = endFrame.origin.y - CGRectGetHeight(bounds);
    
    BOOL animation;
    if (self.emotionView.isShow || self.anotherView.isShow) {
        animation = NO;
    } else {
        animation = YES;
    }
    
    [self resetTableViewFrame:animation];
}

#pragma mark - InputBarDelegate

- (void)didSendMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送文字" message:message delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didChooseTextField {
    self.inputBar.emotionBtn.selected = NO;
    self.inputBar.anotherBtn.selected = NO;
    
    self.emotionViewBottom.constant = CGRectGetHeight(self.emotionView.frame);
    self.emotionView.isShow = NO;
    
    self.anotherViewBottom.constant = CGRectGetHeight(self.anotherView.frame);
    self.anotherView.isShow = NO;
}

- (void)didStartVoice {
    self.navigationItem.title = @"开始录音";
}

- (void)didFinishVoice {
    self.navigationItem.title = @"完成录音";
}

- (void)willCancelVoice {
    self.navigationItem.title = @"将要取消录音";
}

- (void)didCancelledVoice {
    self.navigationItem.title = @"取消录音";
}

- (void)inputBar:(InputBar *)inputBar didSelectedMode:(InputMode)inputMode {
    switch (inputMode) {
        case InputTextMode: {
            [self.inputBar beginEditing];
        }
            break;
        case InputVoiceMode: {
            [self.inputBar endEditing];
            
            self.inputBarBottom.constant = 0.f;
            
            [self didChooseTextField];
            [self resetTableViewFrame:YES];
        }
            break;
        case InputEmotionMode: {
            if (!self.emotionView.isShow) {
                self.emotionView.isShow = YES;
                self.anotherView.isShow = NO;
                
                self.inputBar.anotherBtn.selected = NO;
                
                [self.inputBar endEditing];
                [self.inputBar hideVoiceInput];
                self.inputBarBottom.constant = -1 * CGRectGetHeight(self.emotionView.frame);
                
                self.emotionViewBottom.constant = 0.f;
                self.anotherViewBottom.constant = CGRectGetHeight(self.anotherView.frame);
                
                [self.view bringSubviewToFront:self.emotionView];
                [self resetTableViewFrame:YES];
            }
            
        }
            break;
        case InputAnotherMode: {
            if (!self.anotherView.isShow) {
                self.anotherView.isShow = YES;
                self.emotionView.isShow = NO;
                
                self.inputBar.emotionBtn.selected = NO;
                
                [self.inputBar endEditing];
                [self.inputBar hideVoiceInput];
                
                self.inputBarBottom.constant = -1 * CGRectGetHeight(self.anotherView.frame);
                self.emotionViewBottom.constant = CGRectGetHeight(self.emotionView.frame);
                self.anotherViewBottom.constant = 0.f;
                
                [self.view bringSubviewToFront:self.anotherView];
                [self resetTableViewFrame:YES];
            }
        }
            break;
    }
}

- (void)inputBar:(InputBar *)inputBar didUnSelectedMode:(InputMode)inputMode {
    switch (inputMode) {
        case InputEmotionMode: {
            if (self.emotionView.isShow) {
                self.emotionView.isShow = NO;
                
                [self.inputBar beginEditing];
                
                self.emotionViewBottom.constant = CGRectGetHeight(self.emotionView.frame);
                
                [self resetTableViewFrame:YES];
            }
        }
            break;
        case InputAnotherMode: {
            if (self.anotherView.isShow) {
                self.anotherView.isShow = NO;
                
                [self.inputBar beginEditing];
                
                self.anotherViewBottom.constant = CGRectGetHeight(self.anotherView.frame);
                
                [self resetTableViewFrame:YES];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - AnotherViewDelegate

- (void)didChooseItem:(NSUInteger)index {
    NSDictionary *item = self.anotherItems[index];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"处理事件" message:item[@"title"] delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

@end
