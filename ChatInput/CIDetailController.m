//
//  CIDetailController.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CIDetailController.h"

#import "CITimeCell.h"
#import "CIMessageLeftCell.h"
#import "CIMessageRightCell.h"
#import "CIVocieLeftCell.h"
#import "CIVoiceRightCell.h"
#import "CIEmotionLeftCell.h"
#import "CIEmotionRightCell.h"
#import "CIImageLeftCell.h"
#import "CIImageRightCell.h"

#import "CIConstants.h"

#import "CIInputBar.h"
#import "CIEmotionView.h"
#import "CIAnotherView.h"

@interface CIDetailController () <CIInputBarDelegate, CIEmotionViewDelegate, CIAnotherViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatDetailBottom;

@property (nonatomic, strong) CIInputBar *inputBar;
@property (nonatomic, strong) NSLayoutConstraint *inputBarBottom;

@property (nonatomic, strong) CIEmotionView *emotionView;
@property (nonatomic, strong) NSLayoutConstraint *emotionViewBottom;
@property (nonatomic, strong) NSArray *emotionItems;

@property (nonatomic, strong) CIAnotherView *anotherView;
@property (nonatomic, strong) NSLayoutConstraint *anotherViewBottom;
@property (nonatomic, strong) NSArray *anotherItems;

@property (nonatomic, strong) NSMutableArray *detailArr;
@property (nonatomic, strong) NSMutableDictionary *detailHeightDic;

@end

static NSString *timeCellId = @"CITimeCell";
static NSString *messageLeftCellId = @"CIMessageLeftCell";
static NSString *messageRightCellId = @"CIMessageRightCell";
static NSString *voiceLeftCellId = @"CIVoiceLeftCell";
static NSString *voiceRightCellId = @"CIVoiceRightCell";
static NSString *emotionLeftCellId = @"CIEmotionLeftCell";
static NSString *emotionRightCellId = @"CIEmotionRightCell";
static NSString *imageLeftCellId = @"CIImageLeftCell";
static NSString *imageRightCellId = @"CIImageRightCell";

@implementation CIDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBackToHome:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    self.detailArr = [NSMutableArray array];
    self.detailHeightDic = [NSMutableDictionary dictionary];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.chatDetail registerNib:[UINib nibWithNibName:timeCellId bundle:nil] forCellReuseIdentifier:timeCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:messageLeftCellId bundle:nil] forCellReuseIdentifier:messageLeftCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:messageRightCellId bundle:nil] forCellReuseIdentifier:messageRightCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:voiceLeftCellId bundle:nil] forCellReuseIdentifier:voiceLeftCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:voiceRightCellId bundle:nil] forCellReuseIdentifier:voiceRightCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:emotionLeftCellId bundle:nil] forCellReuseIdentifier:emotionLeftCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:emotionRightCellId bundle:nil] forCellReuseIdentifier:emotionRightCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:imageLeftCellId bundle:nil] forCellReuseIdentifier:imageLeftCellId];
    [self.chatDetail registerNib:[UINib nibWithNibName:imageRightCellId bundle:nil] forCellReuseIdentifier:imageRightCellId];
    
    
    self.emotionItems = @[
                          @{
                              @"title": @"expression",
                              @"imageName": @"EmotionsEmojiHL"
                              }
                          ];
    
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
                              @"imageName": @"CIAnotherContent5"
                              },
                          @{
                              @"title": @"转账",
                              @"imageName": @"CIAnotherContent6"
                              },
                          @{
                              @"title": @"位置",
                              @"imageName": @"CIAnotherContent7"
                              },
                          @{
                              @"title": @"收藏",
                              @"imageName": @"CIAnotherContent8"
                              },
                          @{
                              @"title": @"个人名片",
                              @"imageName": @"CIAnotherContent9"
                              },
                          @{
                              @"title": @"实时对讲机",
                              @"imageName": @"CIAnotherContent10"
                              }
                          ];
    
    [self initInputBar];
    [self initEmotionView];
    [self initAnotherView];
    
    
//    NSArray *tmpArr = @[
//                        @{
//                            @"icon": @"",
//                            @"text": @"双方说法是粉色沙发沙发上"
//                            },
//                        @{
//                            @"icon": @"",
//                            @"text": @"哈哈哈哈哈哈啊啊哈哈哈哈哈啊哈哈哈哈哈啊哈哈哈哈啊哈哈哈哈哈啊哈哈哈哈啊哈哈哈哈哈"
//                            },
//                        @{
//                            @"icon": @"",
//                            @"text": @"2222222dffdfsfsdfadafasfa"
//                            }
//                        ];
    NSArray *tmpArr = @[
                        @{
                            @"icon": @"",
                            @"text": @"jpg1.jpg"
                            },
                        @{
                            @"icon": @"",
                            @"text": @"jpg2.jpg"
                            },
                        @{
                            @"icon": @"",
                            @"text": @"jpg3.jpg"
                            }
                        ];
    [self.detailArr addObjectsFromArray:tmpArr];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)goBackToHome:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Init View

- (void)initInputBar {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //InputBar
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CIInputBar" owner:@"CIInputBar" options:nil];
    self.inputBar = nibViews[0];
    self.inputBar.inputDelegate = self;
    
    [self.view addSubview:self.inputBar];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:CIInputBarHeight];
    [self.inputBar addConstraints:@[width, height]];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
    self.inputBarBottom = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    [self.view addConstraints:@[leading, self.inputBarBottom]];
}

- (void)initEmotionView {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //emotionView
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CIEmotionView" owner:@"CIEmotionView" options:nil];
    self.emotionView = nibViews[0];
    self.emotionView.emotionViewDelegate = self;
    
    [self.view addSubview:self.emotionView];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:CIEmotionViewHeight];
    [self.emotionView addConstraints:@[width, height]];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
    self.emotionViewBottom = [NSLayoutConstraint constraintWithItem:self.emotionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:CIEmotionViewHeight];
    [self.view addConstraints:@[leading, self.emotionViewBottom]];
    
    [self.emotionView addItems:self.emotionItems];
}

- (void)initAnotherView {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    //anotherView
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CIAnotherView" owner:@"CIAnotherView" options:nil];
    self.anotherView = nibViews[0];
    self.anotherView.anotherViewDelegate = self;
    
    [self.view addSubview:self.anotherView];
    
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:size.width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:CIAnotherViewHeight];
    [self.anotherView addConstraints:@[width, height]];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.f constant:0.f];
    self.anotherViewBottom = [NSLayoutConstraint constraintWithItem:self.anotherView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:CIAnotherViewHeight];
    [self.view addConstraints:@[leading, self.anotherViewBottom]];
    
    //1,2; 2,4; 3,6
    [self.anotherView addItems:self.anotherItems row:2 col:4];
}

#pragma mark - GestureRecognizer

- (IBAction)tapOnTableView:(id)sender {
    [self.inputBar endEditing];
    
    self.inputBarBottom.constant = 0.f;
    
    [self didChooseTextView];
    [self resetTableViewFrame:YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CIImageLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:imageLeftCellId forIndexPath:indexPath];
    
    NSDictionary *detail = self.detailArr[indexPath.row];
    
    CGSize cellSize = [self.detailHeightDic[indexPath] CGSizeValue];
    
    //MessageCell
//    if ([detail[@"text"] isKindOfClass:[NSAttributedString class]]) {
//        cell.detailLabel.attributedText = detail[@"text"];
//    } else {
//        cell.detailLabel.text = detail[@"text"];
//    }
//    
//    cell.detailViewConstraintWidth.constant = cellSize.width;
    
    //TimeCell
//    cell.timeLabel.text = detail[@"text"];
//    cell.timeLabelConstraintWidth.constant = cellSize.width;
    
    //ImageCell
    cell.contentImageView.image = [UIImage imageNamed:detail[@"text"]];
    cell.contentImageViewConstraintWidth.constant = cellSize.width;
    cell.contentImageViewConstraintHeight.constant = cellSize.height - 16;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.detailHeightDic[indexPath]) {
        CGSize cellSize = [self.detailHeightDic[indexPath] CGSizeValue];
        
        return cellSize.height;
    } else {
        CGRect rect = [UIScreen mainScreen].bounds;
        
        NSDictionary *detail = self.detailArr[indexPath.row];
        
//        CGSize cellSize;
//        if ([detail[@"text"] isKindOfClass:[NSAttributedString class]]) {
//            CGRect bound = [detail[@"text"] boundingRectWithSize:CGSizeMake(rect.size.width - 84 - 52, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
//            
//            cellSize = CGSizeMake(bound.size.width + 34 + 2 * [detail[@"textCount"] integerValue], bound.size.height + 38);
//        } else {
//            CGRect bound = [detail[@"text"] boundingRectWithSize:CGSizeMake(rect.size.width - 84 - 52, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil];
//            
//            //MessageCell
////            cellSize = CGSizeMake(bound.size.width + 34, bound.size.height + 38);
//            
//            //timeCell
//            cellSize = CGSizeMake(bound.size.width + 10, bound.size.height + 10);
//        }
        
        //ImageCell
        UIImage *image = [UIImage imageNamed:detail[@"text"]];
        
        CGSize cellSize;
        CGFloat p = image.size.width/image.size.height;
        if (p > 1) {
            cellSize.width = 200;
            cellSize.height = 200/p + 16;
        } else {
            cellSize.height = 200 + 16;
            cellSize.width = 200*p;
        }
        
        [self.detailHeightDic setObject:[NSValue valueWithCGSize:cellSize] forKey:indexPath];
        
        return cellSize.height;
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self tapOnTableView:nil];
}

#pragma mark - Private Method

- (void)resetTableViewFrame:(BOOL)animation {
    self.chatDetailBottom.constant = -1 * self.inputBarBottom.constant + CGRectGetHeight(self.inputBar.frame);
    
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    if (self.chatDetail.contentSize.height > CGRectGetHeight(self.chatDetail.frame)) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.detailArr.count - 1 inSection:0];
        [self.chatDetail scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
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

#pragma mark - CIInputBarDelegate

- (void)didSendMessage:(NSString *)message {
    NSDictionary *dic;
    
    //设置表情
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:message];
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
    NSDictionary *expressionDic = [[NSDictionary alloc] initWithContentsOfFile:resourcePath];
    
    NSString *pattern = @"\\[[a-zA-Z0-9\u4e00-\u9fa5]+\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *resultArr = [regex matchesInString:message options:NSMatchingReportProgress range:NSMakeRange(0, message.length)];
    
    if (resultArr.count > 0) {
        NSUInteger messageLength = message.length;
        
        for (int i = (int)resultArr.count - 1; i >= 0; i --) {
            NSTextCheckingResult *result = resultArr[i];
            
            NSString *emotionStr = expressionDic[[message substringWithRange:result.range]];
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            textAttachment.image = [UIImage imageNamed:emotionStr];
            
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
            [attrStr replaceCharactersInRange:result.range withAttributedString:imageStr];
            
            messageLength -= (result.range.length - 1);
        }
        
        dic = @{
                @"icon": @"",
                @"text": attrStr,
                @"textCount": [NSNumber numberWithInteger:messageLength]
                };
    } else {
        dic = @{
                @"icon": @"",
                @"text": message
                };
    }
    
    //重新加载
    [self.detailArr addObject:dic];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.detailArr.count - 1 inSection:0];
    [self.chatDetail insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.chatDetail scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [self.emotionView emotionSendBtnEnable:NO];
}

- (void)didChooseTextView {
    self.inputBar.emotionBtn.selected = NO;
    self.inputBar.anotherBtn.selected = NO;
    
    self.emotionViewBottom.constant = CGRectGetHeight(self.emotionView.frame);
    self.emotionView.isShow = NO;
    
    self.anotherViewBottom.constant = CGRectGetHeight(self.anotherView.frame);
    self.anotherView.isShow = NO;
}

- (void)willChangeTextViewHeight:(CGFloat)height {
    [self resetTableViewFrame:YES];
}

- (void)textView:(BOOL)isExsit {
    [self.emotionView emotionSendBtnEnable:isExsit];
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

- (void)inputBar:(CIInputBar *)inputBar didSelectedMode:(InputMode)inputMode {
    switch (inputMode) {
        case InputTextMode: {
            [self.inputBar beginEditing];
        }
            break;
        case InputVoiceMode: {
            [self.inputBar endEditing];
            
            self.inputBarBottom.constant = 0.f;
            
            [self didChooseTextView];
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

- (void)inputBar:(CIInputBar *)inputBar didUnSelectedMode:(InputMode)inputMode {
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

#pragma mark - CIEmotionViewDelegate

- (void)didChoosedEmotion:(NSString *)emotionKey type:(EmotionType)emotionType {
    switch (emotionType) {
        case EmotionExpressionType: {
            [self.inputBar setText:emotionKey];
        }
            break;
        case EmotionCustomType: {
            
        }
            break;
    }
}

- (void)didDeleteEmotion {
    [self.inputBar deleteText];
}

- (void)didEmotionSendMessage {
    [self.inputBar sendMessage];
}

#pragma mark - CIAnotherViewDelegate

- (void)didChooseItem:(NSUInteger)index {
    NSDictionary *item = self.anotherItems[index];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"处理事件" message:item[@"title"] delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

@end
