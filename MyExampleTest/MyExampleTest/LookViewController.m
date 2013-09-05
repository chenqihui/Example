//
//  LookViewController.m
//  MyExampleTest
//
//  Created by chen on 13-9-3.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "LookViewController.h"

@interface LookViewController ()<UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *_panGestureRecognizer;
}

@end

@implementation LookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    _panGestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)] autorelease];
    _panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:_panGestureRecognizer];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    if(CGRectContainsPoint(rect,point))
    {
        NSLog(@"move(%f, %f)", point.x, point.y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"end(%f, %f)", point.x, point.y);
}

#pragma mark - Handle Gestures

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    if (_panGestureRecognizer == gestureRecognizer)
    {
        CGPoint location = [gestureRecognizer locationInView:self.view];
        NSLog(@"GestureRecognizerhandleend(%f, %f)", location.x, location.y);
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_panGestureRecognizer == gestureRecognizer)
    {
        CGPoint location = [gestureRecognizer locationInView:self.view];
        NSLog(@"GestureRecognizerbegin(%f, %f)", location.x, location.y);
    }
    
    return YES;
}

@end
