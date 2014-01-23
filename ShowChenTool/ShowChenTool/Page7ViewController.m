//
//  Page7ViewController.m
//  ShowChenTool
//
//  Created by chen on 14-1-21.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "Page7ViewController.h"

typedef enum{
    JWLoadMoreNormal = 0,//点击再加载
    JWLoadMoreLoading,//加载中
    JWLoadMoreDone,//无更多数据
    JWLoadMoreRelease,
} JWLoadMoreState;

@interface Page7ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *m_table;
    QHQueueDictionary *m_source;
    JWLoadMoreState m_state;
}

@end

@implementation Page7ViewController

- (void)dealloc
{
    m_table.delegate = nil;
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
        [*source addVlaue:[NSString stringWithFormat:@"row:%d", i] key:[NSNumber numberWithInt:i]];
    }
    m_state = JWLoadMoreNormal;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1)
        return 1;
    return [m_source count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 1)
    {
        NSString *reuseIdentifier = @"load";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"load"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
            [btn setTag:8];
            [btn setBackgroundColor:[UIColor redColor]];
            [btn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchDown];
            [cell addSubview:btn];
        }
        [self setLoadMoreStatus:m_state button:(UIButton *)[cell viewWithTag:8]];
        return cell;
    }
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
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadMore:(id)sender
{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//    });
    static int datasum = 0;
    datasum++;
    [self setLoadMoreStatus:JWLoadMoreLoading];
    m_state = JWLoadMoreLoading;
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
    {
        // code to be executed on the main queue after delay
        for (int i = 0; i < 2; i++)
        {
            [m_source addVlaue:[NSString stringWithFormat:@"row2:%d", i] key:[NSNumber numberWithInt:i]];
        }
        m_state = JWLoadMoreNormal;
        if(datasum == 2)
            m_state = JWLoadMoreDone;
        [m_table reloadData];
    });
}

-(void)setLoadMoreStatus:(JWLoadMoreState)status
{
    [self setLoadMoreStatus:status button:nil];
}

-(void)setLoadMoreStatus:(JWLoadMoreState)status button:(UIButton *)btn
{
//    [m_table reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    if (btn == nil)
    {
        UITableViewCell *cell = [m_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        btn = (UIButton *)[cell viewWithTag:8];
    }
    switch (status)
    {
        case JWLoadMoreNormal:
            [btn setTitle:@"点击再加载" forState:UIControlStateNormal];
            break;
        case JWLoadMoreLoading:
            [btn setTitle:@"加载中" forState:UIControlStateNormal];
            break;
        case JWLoadMoreDone:
            [btn setTitle:@"无更多数据" forState:UIControlStateNormal];
            [btn setEnabled:NO];
            break;
        case JWLoadMoreRelease:
            [btn setTitle:@"放手加载" forState:UIControlStateNormal];
            break;
        default:
            [btn setTitle:@"点击再加载" forState:UIControlStateNormal];
            break;
    }
}

#pragma mark scroll
/*
 计算刷新
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offY          = scrollView.contentOffset.y;
    float contentHeight = scrollView.contentSize.height;
    float boundsHeight  = scrollView.bounds.size.height;
    NSLog(@"offY:%f", offY);
    double d = contentHeight - boundsHeight < 0?0:contentHeight - boundsHeight;
    NSLog(@"d:%f", d);
    if (m_state == JWLoadMoreLoading)
    {
        
    } else if (scrollView.dragging)
    {
        double d = contentHeight - boundsHeight < 0?0:contentHeight - boundsHeight;
        //		if (_state == EGOOPullRefreshPulling && offY > -65.0f && offY < 0.0f && !_loading)
        if (m_state == JWLoadMoreNormal &&
            offY < d + 65 &&
            offY > d)
        {
            m_state = JWLoadMoreRelease;
            [self setLoadMoreStatus:m_state];
		}
        //        else if (_state == EGOOPullRefreshNormal && offY < -65.0f && !_loading)
        else if (m_state == JWLoadMoreLoading &&
                 offY > d + 65)
        {
            [self loadMore:nil];
		}
    } else if(m_state == JWLoadMoreRelease)
    {
        [self loadMore:nil];
    }
    
}

@end
