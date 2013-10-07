//
//  Test1ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Test1ViewController.h"

#import "LotteryEntry.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self e];
}

- (void)e
{
    @autoreleasepool
    {
        NSDate *now = [[NSDate alloc] init];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *weekComponents = [[NSDateComponents alloc] init];
        //创建随机数生成器
        srandom((unsigned)time(NULL));
        NSMutableArray *array;
        array = [[NSMutableArray alloc] init];
        
        int i;
        for (i = 0; i < 10; i++)
        {
            [weekComponents setWeek:i];
            
            //创建日期对象，i周以前的
            NSDate *iWeeksFromNow;
            iWeeksFromNow = [cal dateByAddingComponents:weekComponents toDate:now options:0];
            
            //创建新的LotteryEntry的实例
            LotteryEntry *newEntry = [[LotteryEntry alloc] init];
            [newEntry prepareRandomNumbers];
            [newEntry setEntryDate:iWeeksFromNow];
            
            //将LotteryEntry对象加入到队列中
            [array addObject:newEntry];
            //释放‘newEntry’，这样array就独有newEntry所有权
            [newEntry release];
        }
        //释放‘now’和‘weekComponents’
        [now release];
        [weekComponents release];
        
        for (LotteryEntry *entryToPrint in array)
        {
            NSLog(@"%@", entryToPrint);
        }
        //释放‘array’，此时数组里面的newEntry也会随之释放
        [array release];
    }
}

@end
