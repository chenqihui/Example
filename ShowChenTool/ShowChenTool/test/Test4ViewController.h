//
//  Test4ViewController.h
//  ShowChenTool
//
//  Created by chen on 13-10-4.
//  Copyright (c) 2013年 User. All rights reserved.
//


/*
 还没有实现捆定key-value
 */
#import <UIKit/UIKit.h>

@interface Model : NSObject<NSCoding>
{
    int fido;
    NSNumber *number;
}

@property (nonatomic, retain) NSNumber *number;

- (int)fido;

- (void)setFido:(int)x;

@end

@interface Test4ViewController : UIViewController
{
    Model *m;
}
@property (retain, nonatomic) IBOutlet UISlider *m_slider;
@property (retain, nonatomic) IBOutlet UILabel *m_showLabel;
@property (assign, nonatomic) Model *m;
@property (retain, nonatomic) IBOutlet UILabel *chen;

@end
