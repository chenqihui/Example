//
//  MoveViewController.m
//  MyExampleTest
//
//  Created by chen on 13-9-3.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "MoveViewController.h"

// Percentage limit to trigger certain action
static CGFloat const kRSActionThreshold            = 0.70;
// Maximum bounce amplitude
static CGFloat const kRSBounceAmplitude            = 20.0;
// Duration of the first part of the bounce animation
static NSTimeInterval const kRSBounceDurationForth = 0.2;
// Duration of the second part of the bounce animation
static NSTimeInterval const kRSBounceDurationBack  = 0.1;
// Lowest duration when swipping the cell because we try to simulate velocity
static NSTimeInterval const kRSDurationLowLimit    = 0.25;
// Highest duration when swipping the cell because we try to simulate velocity
static NSTimeInterval const kRSDurationHighLimit   = 0.1;

@interface MYMoveVIew () <UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *_panGestureRecognizer;
}

@end

@implementation MYMoveVIew

- (void)dealloc
{ 
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _panGestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)] autorelease];
        _panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:_panGestureRecognizer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - Handle Gestures

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    if (_panGestureRecognizer == gestureRecognizer)
    {
        UIGestureRecognizerState state = [gestureRecognizer state];
        CGPoint translation = [gestureRecognizer translationInView:self];
        CGPoint velocity = [gestureRecognizer velocityInView:self];
        CGFloat percentage = [self percentageWithOffset:CGRectGetMinX(self.frame) relativeToWidth:CGRectGetWidth(self.bounds)];
        NSLog(@"%f", percentage);
        NSTimeInterval animationDuration = [self animationDurationWithVelocity:velocity];
        RSCardViewSwipeDirection direction = [self directionWithPercentage:percentage];
        
        if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
        {
            CGPoint center = { self.center.x + translation.x, self.center.y };
            [self setCenter:center];
            [self updateAlpha];
            [gestureRecognizer setTranslation:CGPointZero inView:self];
        } else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled)
        {
            if (direction != RSCardViewSwipeDirectionCenter) {
                [self moveWithDuration:animationDuration andDirection:direction];
            } else {
                [self bounceWithDistance:kRSBounceAmplitude * percentage];
            }
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_panGestureRecognizer == gestureRecognizer) {
        UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint velocity = [panGestureRecognizer velocityInView:self];
        return fabsf(velocity.x) > fabsf(velocity.y);
    }
    
    return YES;
}

#pragma mark - Utils

- (CGFloat)percentageWithOffset:(CGFloat)offset relativeToWidth:(CGFloat)width {
    CGFloat percentage = offset / width;
    
    if (percentage < -1.0) percentage = -1.0;
    else if (percentage > 1.0) percentage = 1.0;
    
    return percentage;
}

- (NSTimeInterval)animationDurationWithVelocity:(CGPoint)velocity {
    CGFloat width = CGRectGetWidth(self.bounds);
    NSTimeInterval animationDurationDiff = kRSDurationHighLimit - kRSDurationLowLimit;
    CGFloat horizontalVelocity = velocity.x;
    
    if (horizontalVelocity < -width) horizontalVelocity = -width;
    else if (horizontalVelocity > width) horizontalVelocity = width;
    
    return (kRSDurationHighLimit + kRSDurationLowLimit) - fabs(((horizontalVelocity / width) * animationDurationDiff));
}

- (RSCardViewSwipeDirection)directionWithPercentage:(CGFloat)percentage {
    if (percentage < -kRSActionThreshold) {
        return RSCardViewSwipeDirectionLeft;
    } else if (percentage > kRSActionThreshold) {
        return RSCardViewSwipeDirectionRight;
    } else {
        return RSCardViewSwipeDirectionCenter;
    }
}

- (void)updateAlpha {
    self.alpha = (self.frame.size.width - fabsf(self.frame.origin.x)) / self.frame.size.width;
}

#pragma mark - Movement

- (void)moveWithDuration:(NSTimeInterval)duration andDirection:(RSCardViewSwipeDirection)direction {
    CGRect frame = self.frame;
    
    if (direction == RSCardViewSwipeDirectionLeft) {
        frame.origin.x = -CGRectGetWidth(self.bounds);
    } else {
        frame.origin.x = CGRectGetWidth(self.bounds);
    }
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations: ^{
                         [self setFrame:frame];
                         [self updateAlpha];
                     }
     
                     completion: ^(BOOL finished) {
                         [self removeFromSuperview];
                         
//                         if (_delegate && [_delegate respondsToSelector:@selector(didRemoveFromSuperview:)]) {
//                             [_delegate didRemoveFromSuperview:self];
//                         }
                     }];
}

- (void)bounceWithDistance:(CGFloat)bounceDistance {
    NSLog(@"bounceDistance:%f", bounceDistance);
    [UIView animateWithDuration:kRSBounceDurationForth
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseOut)
                     animations: ^{
                         CGRect frame = self.frame;
                         frame.origin.x = -bounceDistance;//此参数计算不好对应情况
                         NSLog(@"bounceDistance:%f", frame.origin.x);
                         [self setFrame:frame];
                         [self updateAlpha];
                     }
     
                     completion: ^(BOOL forthFinished) {
                         [UIView  animateWithDuration:kRSBounceDurationBack
                                                delay:0
                                              options:UIViewAnimationOptionCurveEaseIn
                                           animations: ^{
                                               CGRect frame = self.frame;
                                               frame.origin.x = 10;
                                               [self setFrame:frame];
                                           }
                          
                                           completion: ^(BOOL backFinished) {
                                           }];
                     }];
}

@end

@interface MoveViewController ()
{
    MYMoveVIew *m_mycell;
}

@end

@implementation MoveViewController

- (void)dealloc
{
    [m_mycell release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    m_mycell = [[MYMoveVIew alloc] initWithFrame:CGRectMake(20, 10, 280, 60)];
    [m_mycell setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:m_mycell];
}

@end
