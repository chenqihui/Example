//
//  ViewController.m
//  TemporaryTest
//
//  Created by chen on 13-10-15.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "ViewController.h"

#import "NextViewViewController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

@interface ViewController ()
{
    NSMutableArray *m_arViews;
    CGPoint startTouch;
    UIViewController *m_lastViewController;
}

@property (nonatomic,assign) BOOL isMoving;

@end

@implementation ViewController

/*
//数组排序的使用
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableDictionary *dic = [[NSMutableDictionary new] autorelease];
    [dic setObject:@"1" forKey:@"A"];
    [dic setObject:@"1" forKey:@"B"];
    [dic setObject:@"1" forKey:@"C"];
    [dic setObject:@"1" forKey:@"D"];
    
    NSArray *myKeys = [dic allKeys];
    NSArray *sortedKeys = [myKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
////    3. 按照key获取对象
//    id firstObject = [dic objectForKey: [sortedKeys objectAtIndex:0]];
    NSLog(@"%@", sortedKeys);
    
    NSString* names[] = {@"8990", @"220091111", @"5", @"7"};
    NSString* values[] = {@"56", @"23.5", @"89.12", @"333.2"};
    NSDictionary* dic1 = [NSDictionary dictionaryWithObjects:(id*)names forKeys:(id*)values count:4];
    NSArray* res = [dic1 keysSortedByValueUsingSelector:@selector(caseInsensitiveCompare:)];
    NSLog(@"%@", res);
    NSLog(@"%@", dic1);
}

-(NSComparisonResult)floatCompare:(NSString*)other
{
    float myValue = [other floatValue];
    float otherValue= [other floatValue];
    if(myValue == otherValue) return NSOrderedSame;
    return (myValue < otherValue ? NSOrderedAscending : NSOrderedDescending);
}

- (NSComparisonResult)caseInsensitiveCompare:(NSString *)aString
{
    return NSOrderedDescending;
}
*/

- (void)dealloc
{
    [m_arViews release];
    [super dealloc];
}

- (void)viewDidLoad
{
    m_arViews = [NSMutableArray new];
    [m_arViews addObject:self];
    UIPanGestureRecognizer *gesture = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)] autorelease];
    [self.view addGestureRecognizer:gesture];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchDown];
}

- (void)next:(id)sender
{
    NextViewViewController *nextView = [[NextViewViewController alloc] init];
    [nextView.view setFrame:self.view.bounds];
    [self push:nextView];
}

- (void)push:(UIViewController *)childViewController
{
    [m_arViews addObject:childViewController];
    [self.view addSubview:childViewController.view];
}

- (void)pop
{
    [m_arViews removeLastObject];
}

- (void)handleGesture:(UIPanGestureRecognizer *)recoginzer
{
    if ([m_arViews count] <= 1) return;
    
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    if (recoginzer.state == UIGestureRecognizerStateBegan)
    {
        _isMoving = YES;
        startTouch = touchPoint;
        
//        if(m_lastViewController)
//            [m_lastViewController.view removeFromSuperview];
        
        m_lastViewController = [m_arViews lastObject];
    }else if (recoginzer.state == UIGestureRecognizerStateEnded)
    {
        _isMoving = NO;
        if (touchPoint.x - startTouch.x > 100)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self pop];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
            }];
        }
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled)
    {
        _isMoving = NO;
    }
    float x = touchPoint.x - startTouch.x;
    NSLog(@"Move to:%f",x);
    // it keeps move with touch
    if (_isMoving && x > 0 && x < 320)
    {
        [self moveViewWithX:x];
    }
}

- (void)moveViewWithX:(float)x
{
//    x = x>320?320:x;
//    x = x<0?0:x;
    [m_lastViewController.view setFrame:CGRectMake(x, m_lastViewController.view.frame.origin.y, m_lastViewController.view.frame.size.width, m_lastViewController.view.frame.size.height)];
}

@end
