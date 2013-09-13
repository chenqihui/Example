//
//  Page1ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-9-12.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Page1ViewController.h"

@interface Page1ViewController ()
{
    NSMutableArray *m_dataMutableArray;
}

@end

@implementation Page1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    m_dataMutableArray = [NSMutableArray new];
    
    OperatePlistFile *operatePlistFile = [[OperatePlistFile new] autorelease];
    //1
    [operatePlistFile read:@"showToolListData" typeDate:&m_dataMutableArray];
    //2
    [operatePlistFile read:@"showToolListData" typeClassDate:@"NSMutableArray" complete:^(id data) {
        m_dataMutableArray = [data retain];
    }];
    //3
    [operatePlistFile read2:@"showToolListData" typeClassDate:@"NSMutableArray" complete:^NSString*(id data) {
        m_dataMutableArray = [data retain];
        return @"over";
    }];
}

@end
