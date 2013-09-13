//
//  ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-9-9.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "ViewController.h"

#import "Page1ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    [self.m_dataMutableArray release];
    [_m_myShowTableView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.m_dataMutableArray = [NSMutableArray new];
    OperatePlistFile *operatePlistFile = [[OperatePlistFile new] autorelease];
//    [operatePlistFile read:@"showToolListData" typeDate:&_m_dataMutableArray];
//    [operatePlistFile read:@"showToolListData" typeClassDate:@"NSMutableArray" complete:^(id data) {
//        _m_dataMutableArray = [data retain];
//    }];
    [operatePlistFile read2:@"showToolListData" typeClassDate:@"NSMutableArray" complete:^NSString*(id data) {
        _m_dataMutableArray = [data retain];
        return @"over";
    }];
}

#pragma mark - UITableViewDataSource

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0)
//    {
//        CGSize s1 = [s sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(300, INT_MAX) lineBreakMode:UILineBreakModeWordWrap];
//        return  s1.height;
//    }
//    return 30;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_m_dataMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
    }
    cell.textLabel.text = [_m_dataMutableArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *page = [NSString stringWithFormat:@"Page%dViewController", indexPath.row + 1];
    Class cls = NSClassFromString(page);
    UIViewController *mvc = [[[cls alloc] init] autorelease];
    
    if(mvc != nil)
        [self.navigationController pushViewController:mvc animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
