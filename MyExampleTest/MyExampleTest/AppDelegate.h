//
//  AppDelegate.h
//  MyExampleTest
//
//  Created by chen on 13-8-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMKMapManager.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
