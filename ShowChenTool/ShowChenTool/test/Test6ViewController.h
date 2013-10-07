//
//  Test6ViewController.h
//  ShowChenTool
//
//  Created by chen on 13-10-4.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    red = 1,
    green,
    yellow
}Lighting;

@interface MyView : UIView
{
    UIView *m_arRed;
    UIView *m_arGreen;
    UIView *m_arYellow;
    
    Lighting lighting;
    Lighting lighted;
}

@property (nonatomic, assign) Lighting lighting;

@end

@interface Test6ViewController : UIViewController

@end
