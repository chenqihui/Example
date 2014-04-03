//
//  Page9ViewController.m
//  ShowChenTool
//
//  Created by chen on 14-4-3.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "Page9ViewController.h"

@interface Page9ViewController ()<SFCountdownViewDelegate>
{
    SFCountdownView *_sfCountdownView;
}

@end

@implementation Page9ViewController

- (void)dealloc
{
    [_sfCountdownView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _sfCountdownView = [[SFCountdownView alloc] initWithFrame:self.view.bounds];
    _sfCountdownView.delegate = self;
    _sfCountdownView.backgroundAlpha = 0.2;
    _sfCountdownView.countdownColor = [UIColor blackColor];
    _sfCountdownView.countdownFrom = 3;
    _sfCountdownView.finishText = @"Do it";
    [_sfCountdownView updateAppearance];
    
    [self.view addSubview:_sfCountdownView];
    
    UIButton *open = [UIButton buttonWithType:UIButtonTypeCustom];
    open.frame = CGRectMake(140, 350, 40, 20);
    [open setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [open setTitle:@"start" forState:UIControlStateNormal];
    [open addTarget:self action:@selector(startButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:open];
}

- (void) viewDidAppear:(BOOL)animated
{
    [_sfCountdownView start];
}

- (void) startButton
{
    [_sfCountdownView updateAppearance];
    [self.view addSubview:_sfCountdownView];
    [self.view setNeedsDisplay];
    [_sfCountdownView start];
}

- (void) countdownFinished:(SFCountdownView *)view
{
    [_sfCountdownView removeFromSuperview];
    [self.view setNeedsDisplay];
}

@end
