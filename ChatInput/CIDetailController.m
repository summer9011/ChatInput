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

@interface CIDetailController () <InputBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *chatDetail;

@property (nonatomic, strong) InputBar *inputBar;

@end

static NSString *CellIdentifier = @"CIDetailCell";

@implementation CIDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.chatDetail registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    [self initInputBar];
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
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.inputBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0.f];
    [self.view addConstraints:@[leading, bottom]];
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
    NSLog(@"%@", indexPath);
}

#pragma mark - Notification

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    
}

#pragma mark - InputBarDelegate

- (void)inputBar:(InputBar *)inputBar didSelectedMode:(InputMode)inputMode {
    
}

- (void)inputBar:(InputBar *)inputBar didUnSelectedMode:(InputMode)inputMode {
    
}

@end
