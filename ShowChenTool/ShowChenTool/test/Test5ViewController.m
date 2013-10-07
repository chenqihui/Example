//
//  Test5ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-4.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Test5ViewController.h"

@interface Test5ViewController ()
{
    NSMutableArray *m_ar;
}

@end

@implementation Test5ViewController

- (void)dealloc
{
    [m_ar release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    m_ar = [NSMutableArray new];
}

- (IBAction)remove:(id)sender
{
    [self removeObjectAtIndex:0];
}

- (IBAction)insert:(id)sender
{
    [self insertObject:@"1" atIndex:0];
}

- (IBAction)look:(id)sender
{
    NSLog(@"%@", m_ar);
}

- (void)removeObjectAtIndex:(int)index
{
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] insertObject:@"1" atIndex:index];
    if ([undo isUndoing])
    {
        [undo setActionName:@"remove"];
    }
    [m_ar removeObjectAtIndex:index];
}

- (void)insertObject:(NSString *)str atIndex:(int)index
{
    NSUndoManager *undo = [self undoManager];
    [[undo prepareWithInvocationTarget:self] removeObjectAtIndex:index];
    if ([undo isUndoing])
    {
        [undo setActionName:@"add"];
    }
    [m_ar addObject:str];
}

@end
