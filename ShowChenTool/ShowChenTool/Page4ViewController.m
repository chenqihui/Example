//
//  Page4ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Page4ViewController.h"

@interface Page4ViewController ()

@end

@implementation Page4ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self e];
}

- (void)e
{
    NSMutableDictionary *dic = [[NSMutableDictionary new] autorelease];
    [dic setValue:@"1" forKey:@"1、test"];
    [dic setValue:@"2" forKey:@"2、test"];
    NSLog(@"%@", dic);
    NSArray *arKeys = [dic allKeys];
    NSLog(@"%@", arKeys);
    
//    [dic objectForKey:@""];
//    
//    NSMutableArray *ar = [NSMutableArray new];
//    [ar insertObject:@"1" atIndex:0];
    
//    QHQueueDictionary *qdic = [[[QHQueueDictionary alloc] init] autorelease];
//    [qdic insertKeyValuePairAtIndex:3 withKeyValuePair:[QHKeyValuePair initWithValue:@"1" key:@"2"]];
//    NSLog(@"%@", qdic);
//    
//    NSArray *ar = [qdic allKeys];
//    NSLog(@"%@", ar);
//    [qdic removeAllKeyValuePairs];
//    NSLog(@"%@", [qdic firstkeyValuePair]);
}

@end
