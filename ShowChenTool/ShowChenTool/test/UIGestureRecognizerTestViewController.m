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
    UIImageView *dragonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dragon.png"]];
    snakeImageView.frame = CGRectMake(120, 120, 100, 160);
    dragonImageView.frame = CGRectMake(50, 50, 100, 160);
    [self.view addSubview:snakeImageView];
    [self.view addSubview:dragonImageView];
    snakeImageView.userInteractionEnabled = YES;
    dragonImageView.userInteractionEnabled = YES;
    
    for (UIView *view in self.view.subviews)
    {
        //3、Pan 拖动手势：
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(handlePan:)];
        //4、Pinch缩放手势
        UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handlePinch:)];
        //5、Rotation旋转手势
        UIRotationGestureRecognizer *rotateRecognizer = [[UIRotationGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:@selector(handleRotate:)];
        
        [view addGestureRecognizer:panGestureRecognizer];
        [view addGestureRecognizer:pinchGestureRecognizer];
        [view addGestureRecognizer:rotateRecognizer];
    }
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void) handlePan:(UIPanGestureRecognizer*)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //获取拖动时X和Y轴上的速度，速度是矢量，有方向:velocity
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
        
    }
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (void) handleRotate:(UIRotationGestureRecognizer*) recognizer
{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

@end
