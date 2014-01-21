//
//  Page7ViewController.m
//  ShowChenTool
//
//  Created by chen on 14-1-21.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "Page7ViewController.h"

@interface Page7ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *m_table;
    QHQueueDictionary *m_source;
}

@end

@implementation Page7ViewController

- (void)dealloc
{
    [m_table release];
    [m_source release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initData:&m_source];
    
    m_table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_table.dataSource = self;
    m_table.delegate = self;
    [self.view addSubview:m_table];
    
    NSLog(@"tabelY:%f", m_table.frame.origin.y);
    
}

- (void)initData:(QHQueueDictionary **)source
{
    if(*source == nil)
        *source = [[QHQueueDictionary alloc] init];
    [*source addVlaue:@"1" key:@"test1"];
    for (int i = 0; i < 10; i++)
    {
        [*source addVlaue:[NSString stringWithFormat:@"row%d", i] key:[NSNumber numberWithInt:i]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [m_source count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
        CGSize s = [@"陈" sizeWithFont:[UIFont systemFontOfSize:14]];
        UILabel *title = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, s.height)] autorelease];
        title.tag = 1000;
        title.font = [UIFont systemFontOfSize:14];
        title.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:title];
        
        UILabel *detail = [[[UILabel alloc] initWithFrame:CGRectMake(0, title.frame.size.height + 5, self.view.frame.size.width, 0)] autorelease];
        detail.tag = 2000;
        detail.lineBreakMode = NSLineBreakByCharWrapping;
        detail.numberOfLines = 0;
        detail.font = [UIFont systemFontOfSize:12];
        detail.textColor = [UIColor blueColor];
        detail.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:detail];
    }
//    ((UILabel *)[cell viewWithTag:1000]).text = [(NSNumber *)[m_source getKeyForIndex:indexPath.row] stringValue];
    CGSize s2 = [[m_source getValueForIndex:indexPath.row] sizeWithFont:[UIFont systemFontOfSize:12]
                                                      constrainedToSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT)
                                                          lineBreakMode:NSLineBreakByCharWrapping];
    UILabel * detail = (UILabel *)[cell viewWithTag:2000];
    [detail setFrame:CGRectMake(0, detail.frame.origin.y, self.view.frame.size.width, s2.height)];
    detail.text = [m_source getValueForIndex:indexPath.row];
    
    return cell;
}

#pragma delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize s = [@"陈" sizeWithFont:[UIFont systemFontOfSize:14]];
    CGSize s2 = [[m_source getValueForIndex:indexPath.row] sizeWithFont:[UIFont systemFontOfSize:12]
                                                      constrainedToSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT)
                                                          lineBreakMode:NSLineBreakByCharWrapping];
    return s.height + 5 + s2.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
