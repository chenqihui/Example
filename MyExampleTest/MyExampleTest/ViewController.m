//
//  ViewController.m
//  MyExampleTest
//
//  Created by chen on 13-8-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "ViewController.h"

#import "TestOneViewController.h"
#import "PanGestureRecoginzerViewController.h"
#import "CHMyTableViewController.h"
#import "FillAffairViewController.h"
#import "BaiDuMapViewController.h"
#import "MoveViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
//    [_tableview release];
    [_dataMutableArray release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStyleDone target:self action:@selector(tableViewEdit:)];
    
    self.dataMutableArray = [[NSMutableArray arrayWithCapacity:0] retain];
    for (int i = 0; i < 50; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [_dataMutableArray addObject:str];
    }
}

- (void)tableViewEdit:(id)sender{
//    [_tableview setEditing:!self.tableview.editing animated:YES];
    
    UIMenuController *theMenu = [UIMenuController sharedMenuController];
    [theMenu setTargetRect:CGRectMake(30, 100, 30, 20) inView:_tableview];
    [theMenu setMenuVisible:YES animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataMutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
    }
    cell.detailTextLabel.text = [_dataMutableArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *mvc = nil;
    switch (indexPath.row)
    {
        case 0:
            mvc = [[[TestOneViewController alloc] init] autorelease];
            break;
        case 1:
            mvc = [[[PanGestureRecoginzerViewController alloc] init] autorelease];
            break;
        case 2:
            mvc = [[[CHMyTableViewController alloc] init] autorelease];
            break;
        case 3:
            mvc = [[[CFillAffairViewController alloc] init] autorelease];
            break;
        case 4:
            mvc = [[[BaiDuMapViewController alloc] init] autorelease];
            break;
        case 5:
            mvc = [[[MoveViewController alloc] init] autorelease];
            break;
        default:
            break;
    }
    if(mvc != nil)
        [self.navigationController pushViewController:mvc animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
