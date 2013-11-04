//
//  ViewController.m
//  TemporaryTest
//
//  Created by chen on 13-10-15.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "ViewController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

@interface ViewController ()
{
    NSMutableArray *m_arViews;
}

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
    UIPanGestureRecognizer *gesture = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)] autorelease];
    [self.view addGestureRecognizer:gesture];
}

- (void)push:(UIViewController *)childViewController
{
    [m_arViews addObject:childViewController];
    [self.view addSubview:childViewController.view];
}

- (void)pop
{
    
}

- (void)handleGesture:(UIPanGestureRecognizer *)recoginzer
{
    if ([m_arViews count] <= 1) return;
    
    if (recoginzer.state == UIGestureRecognizerStateBegan)
    {
    }else if (recoginzer.state == UIGestureRecognizerStateEnded)
    {
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled)
    {
    }
}

@end
