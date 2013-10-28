//
//  Page6ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-28.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Page6ViewController.h"

@interface Page6ViewController ()<QHRecordUtilDelegate>
{
    QHQueueDictionary *m_qds;
    QHRecordUtil *m_recordUtil;
}

@end

@implementation Page6ViewController

- (void)dealloc
{
    [m_qds release];
    [m_recordUtil release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    m_qds = [[QHQueueDictionary alloc] init];
    m_recordUtil = [[QHRecordUtil alloc] init];
    m_recordUtil.m_delegate = self;
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 88, self.view.frame.size.width, 44)] autorelease];
    [view setBackgroundColor:[UIColor blueColor]];
    [self.view insertSubview:view aboveSubview:self.tableView];
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [recordBtn setFrame:CGRectMake(10, 2, view.frame.size.width - 20, 40)];
    [view addSubview:recordBtn];
    
    [recordBtn addTarget:self action:@selector(startRecordBtn:) forControlEvents:UIControlEventTouchDown];
    [recordBtn addTarget:self action:@selector(endRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
    [recordBtn addTarget:self action:@selector(cancelRecordBtn:) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)startRecordBtn:(UIButton *)sender
{
    [m_recordUtil startRecord:@"test.wav"];
}

- (void)endRecordBtn:(UIButton *)sender
{
    
}

- (void)cancelRecordBtn:(UIButton *)sender
{
    [m_recordUtil stopRecord:nil];
}

#pragma mark -

- (void)finishEndRecord:(QHRecordUtil *)recordUtil path:(NSString *)szPath
{
    NSString *str = [[szPath retain] autorelease];
    [m_qds addVlaue:str key:[NSNumber numberWithFloat:recordUtil.recordTime]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_qds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
        
        NSMutableArray *arImages = [[NSMutableArray alloc] init];
        [arImages addObject:[UIImage imageNamed:@"img_messagerecord_one.png"]];
        [arImages addObject:[UIImage imageNamed:@"img_messagerecord_two.png"]];
        [arImages addObject:[UIImage imageNamed:@"img_messagerecord_three.png"]];
        
        UIButton *radiocontrol = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [radiocontrol setFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 30)];
        [radiocontrol addTarget:self action:@selector(listenRadio:) forControlEvents:UIControlEventTouchDown];
        [cell.contentView addSubview:radiocontrol];
        
        UILabel *radioLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        [radioLabel setFont:[UIFont systemFontOfSize:12]];
        radioLabel.userInteractionEnabled = NO;
        [radiocontrol addSubview:radioLabel];
        radioLabel.tag = 100;
        [radioLabel setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *radioImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(radioLabel.frame.origin.x +  radioLabel.frame.size.width + 5, 5, 15, 20)] autorelease];
        radioImageView.tag = 101;
        [radioImageView setImage:[UIImage imageNamed:@"img_messagerecord_btn.png"]];
        radioImageView.userInteractionEnabled = NO;
        [radiocontrol addSubview:radioImageView];
        radioImageView.animationImages = arImages;
        radioImageView.animationDuration = 1;
        
        [arImages release];
    }
    NSString *sztime = [NSString stringWithFormat:@"%@''", [m_qds getKeyForIndex:[indexPath row]]];
    CGSize s = [sztime sizeWithFont:[UIFont systemFontOfSize:12]];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    [label setFrame:CGRectMake(0, 0, s.width, 30)];
    [label setText:sztime];
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:101];
    [imageView setFrame:CGRectMake(label.frame.origin.x + label.frame.size.width + 5, 5, 15, 20)];
    
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
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
