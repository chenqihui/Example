//
//  Test3ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-3.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Test3ViewController.h"

@interface Test3ViewController ()<UITextFieldDelegate>
{
    NSMutableArray *m_source;
    UITextField *m_currenttextfield;
    
    NSLock *m_lock;
}

@end

@implementation Test3ViewController

- (void)dealloc
{
    [m_source release];
    [m_lock release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = addBtnItem;
    
    m_source = [[NSMutableArray alloc] initWithObjects:@"one", @"two", @"three", nil];
    m_lock = [[NSLock alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_source count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UITextField *txfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, cell.frame.size.height)];
        txfield.delegate = self;
        txfield.tag = 1000;
        
        [cell.contentView addSubview:txfield];
    }
    
    // Configure the cell...
    if([m_source objectAtIndex:[indexPath row]] != [NSNull null])
        ((UITextField *)[cell viewWithTag:1000]).text = [m_source objectAtIndex:[indexPath row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

- (void)add:(UIBarButtonItem *)sender
{
    NSLog(@"%@", NSStringFromSelector(sender.action));
//    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:[m_source count] inSection:0];
//    [m_source addObject:[NSNull null]];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationFade];
//    if ([m_lock tryLock])
//    {
//    dispatch_async(dispatch_get_main_queue(), ^
//    {

    if ([m_currenttextfield isFirstResponder])
    {
        [m_currenttextfield resignFirstResponder];
    }
        [m_source addObject:[NSNull null]];
        [self.tableView reloadData];
//    });
//        [m_lock unlock];
//    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"1");
    m_currenttextfield = textField;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    CGRect f = [[m_currenttextfield superview] convertRect:m_currenttextfield.frame toView:self.tableView];
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    NSLog(@"%d", [indexPath row]);
//    CGPoint currentTouchPosition = [touch locationInView:m_ctable];
//    NSIndexPath *indexPath = [m_ctable indexPathForRowAtPoint:currentTouchPosition];
//    if (indexPath != nil)
    
    CGPoint currentTouchPosition = [[textField superview] convertPoint:textField.center toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:currentTouchPosition];
    NSLog(@"%d", [indexPath row]);
    if(textField.text.length > 0)
    {
//        if ([m_lock tryLock])
//        {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [m_source replaceObjectAtIndex:indexPath.row withObject:textField.text];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        });
//            [m_lock unlock];
//        }
    }
    NSLog(@"%@", m_source);
}

@end
