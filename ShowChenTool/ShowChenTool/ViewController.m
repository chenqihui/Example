//
//  ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-9-9.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "ViewController.h"

#import "CHENTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [CHENTool speak:@"你好"];
    
    CHENTool *c = [[CHENTool alloc] init];
    UIView *v = [[[c addView:CGRectMake(10, 10, 100, 30)] retain] autorelease];
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
