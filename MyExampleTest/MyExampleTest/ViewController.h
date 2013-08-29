//
//  ViewController.h
//  MyExampleTest
//
//  Created by chen on 13-8-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (retain, nonatomic) IBOutlet UITableView *tableview;

@property (retain, nonatomic) NSMutableArray *dataMutableArray;

@end
