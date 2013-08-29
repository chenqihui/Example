//
//  Pan2ViewController.m
//  MyExampleTest
//
//  Created by chen on 13-8-6.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Pan2ViewController.h"

@interface Pan2ViewController ()

@end

@implementation Pan2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, 0, 100, 30)];
    btn.center = self.view.center;
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)click
{
    [self.view removeFromSuperview];
}

@end
