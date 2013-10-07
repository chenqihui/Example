//
//  Page3ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-9-22.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Page3ViewController.h"

@implementation MyEntityObject

@synthesize m_szName, m_szAddress, m_nAge;

- (void)dealloc
{
    [m_szName release];
    [m_szAddress release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        m_szName = @"1";
        m_szAddress = @"2";
        m_nAge = 0;
    }
    return self;
}

@end

@interface Page3ViewController ()

@end

@implementation Page3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MyEntityObject *myEntityObj = [MyEntityObject new];
    ReflectPropertyValue *reflect = [ReflectPropertyValue new];
    NSMutableDictionary *dic = [[[reflect reflectDataFromOtherObject:myEntityObj] retain] autorelease];
    if (dic != nil) {
        NSLog(@"%@", dic);
    }
}

@end
