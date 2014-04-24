//
//  UIGestureRecognizerTestViewController.m
//  ShowChenTool
//
//  Created by chen on 14-4-24.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "UIGestureRecognizerTestViewController.h"

@interface UIGestureRecognizerTestViewController ()

@end

@implementation UIGestureRecognizerTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImageView *snakeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snake.png"]];
    snakeImageView.frame = CGRectMake(50, 50 + 64, 100, 160);
    snakeImageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePinch:)];
    [snakeImageView addGestureRecognizer:pinchGestureRecognizer];
    
    [snakeImageView addGestureRecognizer:panGestureRecognizer];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:snakeImageView];
}

- (void)handlePan:(UIPanGestureRecognizer*)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

@end
