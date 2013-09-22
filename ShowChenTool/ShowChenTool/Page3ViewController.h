//
//  Page3ViewController.h
//  ShowChenTool
//
//  Created by chen on 13-9-22.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEntityObject : NSObject
{
    NSString *m_szName;
    NSString *m_szAddress;
    int m_nAge;
}

@property (nonatomic, retain) NSString *m_szName;
@property (nonatomic, retain) NSString *m_szAddress;
@property (nonatomic, assign) int m_nAge;

@end

@interface Page3ViewController : UIViewController

@end
