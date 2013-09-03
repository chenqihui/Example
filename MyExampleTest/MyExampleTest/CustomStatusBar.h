//
//  CustomStatusBar.h
//  MyExampleTest
//
//  Created by chen on 13-9-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomStatusBar : UIWindow
{
    UILabel *_messageLabel;
}

- (void)showStatusMessage:(NSString *)message;
- (void)hide;

@end
