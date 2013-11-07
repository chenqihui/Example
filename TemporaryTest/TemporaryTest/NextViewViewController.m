//
//  NextViewViewController.m
//  TemporaryTest
//
//  Created by chen on 13-11-5.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "NextViewViewController.h"
#import "SWTableViewCell.h"

@interface NextViewViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
{
    UITableView *m_table;
    NSMutableArray *_testArray;
}

@end

@implementation NextViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self initTabelView];
}

- (void)initTabelView
{
    m_table = [[UITableView alloc] initWithFrame:self.view.bounds];
    m_table.dataSource = self;
    m_table.delegate = self;
    [self.view addSubview:m_table];
    
    _testArray = [[NSMutableArray alloc] init];
    
    // Add test data to our test array
    [_testArray addObject:[NSDate date]];
    [_testArray addObject:[NSDate date]];
    [_testArray addObject:[NSDate date]];
}

#pragma mark - table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_testArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    if(!cell)
    //    {
    //        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
    //    }
    //    cell.textLabel.text = [[_testArray objectAtIndex:[indexPath row]] description];
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSMutableArray *leftUtilityButtons = [NSMutableArray new];
        NSMutableArray *rightUtilityButtons = [NSMutableArray new];
        
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"check.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:1.0f blue:0.35f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"clock.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"cross.png"]];
        [leftUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.55f green:0.27f blue:0.07f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"list.png"]];
        
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                 title:@"More"];
        [rightUtilityButtons addUtilityButtonWithColor:
         [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                 title:@"Delete"];
        
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier
                                  containingTableView:m_table // Used for row height and selection
                                   leftUtilityButtons:leftUtilityButtons
                                  rightUtilityButtons:rightUtilityButtons];
        cell.delegate = self;
    }
    
    NSDate *dateObject = _testArray[indexPath.row];
    cell.textLabel.text = [dateObject description];
    cell.detailTextLabel.text = @"Some detail text";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_testArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
