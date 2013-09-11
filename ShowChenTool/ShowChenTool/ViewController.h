//
//  ViewController.h
//  ShowChenTool
//
//  Created by chen on 13-9-9.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *m_myShowTableView;

@property (retain, nonatomic) NSMutableArray *m_dataMutableArray;

@end
