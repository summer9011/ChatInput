//
//  ViewController.m
//  ChatInput
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"

#import "CIDetailController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToChat:(id)sender {
    CIDetailController *chatDetail = [[CIDetailController alloc] initWithNibName:@"CIDetailController" bundle:nil];
    
    [self.navigationController pushViewController:chatDetail animated:YES];
}

@end
