//
//  PanGestureRecoginzerViewController.m
//  MyExampleTest
//
//  Created by chen on 13-8-6.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "PanGestureRecoginzerViewController.h"

#import "Pan2ViewController.h"

@interface PanGestureRecoginzerViewController ()
{
    Pan2ViewController *vcl;
}

@end

@implementation PanGestureRecoginzerViewController

- (void)dealloc
{
    [vcl release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(0, 0, 100, 30)];
    btn.center = self.view.center;
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILongPressGestureRecognizer *recognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)] autorelease];
    [self.view addGestureRecognizer:recognizer];
}

- (void)click
{
//    if(vcl == nil)
//        vcl = [[Pan2ViewController alloc] init];
//    [vcl.view setFrame:self.view.bounds];
//    [self.view addSubview:vcl.view];
    
    UIMenuController *theMenu = [UIMenuController sharedMenuController];
    [theMenu setTargetRect:CGRectMake(0, 60, 30, 20) inView:self.view];
    [theMenu setMenuVisible:YES animated:YES];
}

- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
//        CGPoint p = [recognizer locationInView:self.view];
//        NSIndexPath *indexPath = [self.view indexPathForRowAtPoint:p];
//        
        UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"Flag" action:@selector(flag:)];
        UIMenuItem *approve = [[UIMenuItem alloc] initWithTitle:@"Approve" action:@selector(approve:)];
        UIMenuItem *deny = [[UIMenuItem alloc] initWithTitle:@"Deny" action:@selector(deny:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        [menu setMenuItems:[NSArray arrayWithObjects:flag, approve, deny, nil]];
        [menu setTargetRect:self.view.frame inView:self.view];
        [menu setMenuVisible:YES animated:YES];
        
        
//		UIMenuController *theMenu = [UIMenuController sharedMenuController];
//		[theMenu setTargetRect:CGRectMake(0, 60, 30, 20) inView:self.view];
//		[theMenu setMenuVisible:YES animated:YES];
    }
}

// Touch handling, tile selection, and menu/pasteboard.
- (BOOL)canBecomeFirstResponder {
	return YES;
}

#pragma mark -
#pragma mark Menu commands and validation

/*
 The view implements this method to conditionally enable or disable commands of the editing menu.
 The canPerformAction:withSender method is declared by UIResponder.
 */

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return YES;
}


/*
 These methods are declared by the UIResponderStandardEditActions informal protocol.
 */
- (void)copy:(id)sender {
}


- (void)cut:(id)sender {
}


- (void)paste:(id)sender {
}

@end
