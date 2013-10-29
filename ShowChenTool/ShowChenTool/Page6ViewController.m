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
    
    UIImageView *m_currentImageView;
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
    
    m_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    m_table.dataSource = self;
    m_table.delegate = self;
//    [self.view addSubview:m_table];
    
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)] autorelease];
    [view setBackgroundColor:[UIColor blueColor]];
//    [self.view insertSubview:view aboveSubview:self.tableView];
    [self.view addSubview:view];
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [recordBtn setFrame:CGRectMake(20, 6, view.frame.size.width - 40, 32)];
    [recordBtn setBackgroundColor:[UIColor greenColor]];
    [view addSubview:recordBtn];
    
    [recordBtn addTarget:self action:@selector(startRecordBtn:) forControlEvents:UIControlEventTouchDown];
    [recordBtn addTarget:self action:@selector(endRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
    [recordBtn addTarget:self action:@selector(cancelRecordBtn:) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)startRecordBtn:(UIButton *)sender
{
//    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)] autorelease];
//    [view setBackgroundColor:[UIColor redColor]];
//    view.center = [[UIApplication sharedApplication] keyWindow].center;
//    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
//    [keywindow addSubview:view];
    NSLog(@"startRecordBtn");
    [m_recordUtil startRecord:[NSString stringWithFormat:@"test%d.wav", [m_qds count]]];
}

- (void)endRecordBtn:(UIButton *)sender
{
    NSLog(@"endRecordBtn");
    [m_recordUtil finishRecord];
}

- (void)cancelRecordBtn:(UIButton *)sender
{
    NSLog(@"cancelRecordBtn");
    [m_recordUtil stopRecord:nil];
}

- (void)listenRadio:(UIButton *)sender event:(id)event
{
    if(m_currentImageView != nil)
    {
        if([m_currentImageView isAnimating])
            [m_currentImageView stopAnimating];
        m_currentImageView = nil;
        return;
    }
//    NSSet*touches =[event allTouches];
//    UITouch*touch =[touches anyObject];
//    CGPoint currentTouchPosition =[touch locationInView:m_ctable];
//    NSIndexPath*indexPath =[m_ctable indexPathForRowAtPoint:currentTouchPosition];
    CGRect f = [[sender superview] convertRect:sender.frame toView:m_table];
    NSIndexPath *indexPath = [m_table indexPathForRowAtPoint:f.origin];
    UITableViewCell *cell = [m_table cellForRowAtIndexPath:indexPath];
    NSLog(@"%d", indexPath.row);
    [m_recordUtil playAudio:[m_qds getValueForIndex:indexPath.row]];
    
    m_currentImageView = (UIImageView *)[cell.contentView viewWithTag:101];
    [m_currentImageView startAnimating];
}

#pragma mark -

- (void)finishEndRecord:(QHRecordUtil *)recordUtil path:(NSString *)szPath
{
    [m_qds addVlaue:szPath key:[NSNumber numberWithFloat:recordUtil.recordTime]];
    [m_table reloadData];
}

- (void)finishEndPlayAudio:(QHRecordUtil *)recordUtil
{
    [m_currentImageView stopAnimating];
    m_currentImageView = nil;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableArray *arImages = [[NSMutableArray alloc] init];
        [arImages addObject:[UIImage imageNamed:@"img_messagerecord_one.png"]];
        [arImages addObject:[UIImage imageNamed:@"img_messagerecord_two.png"]];
        [arImages addObject:[UIImage imageNamed:@"img_messagerecord_three.png"]];
        
        UIButton *radiocontrol = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [radiocontrol setFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 30)];
        [radiocontrol addTarget:self action:@selector(listenRadio:event:) forControlEvents:UIControlEventTouchDown];
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
