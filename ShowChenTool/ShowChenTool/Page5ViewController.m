//
//  Page5ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Page5ViewController.h"

@interface Page5ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *m_table;
    QHQueueDictionary *m_source;
    NSMutableDictionary *_dicData;
}

@end

@implementation Page5ViewController

- (void)dealloc
{
    [m_table release];
    [m_source release];
    [_dicData release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _dicData = [NSMutableDictionary new];
    [_dicData setValue:@"UIGestureRecognizerTestViewController" forKey:@"Test8ViewController"];
    NSMutableDictionary *source = [[NSMutableDictionary new] autorelease];
    QHOperatePlistFile *operatePlistFile = [[QHOperatePlistFile new] autorelease];
    [operatePlistFile read:@"testSource" typeDate:&source];
    m_source = [[QHQueueDictionary alloc] init];
    [m_source transformDictionaryToQHQueueDictionary:source];
    
    m_table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_table.dataSource = self;
    m_table.delegate = self;
    [self.view addSubview:m_table];
//    [RDP startServer];
    
    
//    NSLog(@"tabelY:%f", m_table.frame.origin.y);
    
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
    ((UILabel *)[cell viewWithTag:1000]).text = [m_source getKeyForIndex:indexPath.row];
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
    NSString *page = [NSString stringWithFormat:@"Test%dViewController", indexPath.row + 1];
    if (indexPath.row + 1 > 7)
    {
        page = [_dicData valueForKey:page];
    }
    Class cls = NSClassFromString(page);
    UIViewController *mvc = [[[cls alloc] init] autorelease];
    
    if(mvc != nil)
        [self.navigationController pushViewController:mvc animated:YES];
}

#pragma mark scroll

static int _lastPosition;

static BOOL m_bScoll;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
//    printN(currentPostion);
    if (currentPostion - _lastPosition > 20  && currentPostion > 0)//这个地方加上 currentPostion > 0 即可）
    {
        if(m_table.frame.size.height >= m_table.contentSize.height)
            return;
        _lastPosition = currentPostion;
    }
    else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20) ) //这个地方加上后边那个即可，也不知道为什么，再减20才行
    {
        if(!m_bScoll)
            return;
        _lastPosition = currentPostion;
        
        NSLog(@"ScrollDown now");
    }
}

@end
