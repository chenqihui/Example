//
//  Test6ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-4.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Test6ViewController.h"

@implementation MyView

@synthesize lighting;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        lighting = 0;
        
        m_arRed = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 30, 20, 60, 60)];
        m_arGreen = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 30, 90, 60, 60)];
        m_arYellow = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 30, 160, 60, 60)];
        [self addSubview:m_arRed];
        [self addSubview:m_arGreen];
        [self addSubview:m_arYellow];
        
        // 必須加上這一行，這樣圓角才會加在圖片的「外側」
        m_arRed.layer.masksToBounds = YES;
        // 其實就是設定圓角，只是圓角的弧度剛好就是圖片尺寸的一半
        m_arRed.layer.cornerRadius = 60 / 2.0;
        m_arRed.layer.borderColor = [UIColor blackColor].CGColor;
        m_arRed.layer.borderWidth = 1;
        
        m_arGreen.layer.masksToBounds = YES;
        m_arGreen.layer.cornerRadius = 60 / 2.0;
        m_arGreen.layer.borderColor = [UIColor blackColor].CGColor;
        m_arGreen.layer.borderWidth = 1;
        
        m_arYellow.layer.masksToBounds = YES;
        m_arYellow.layer.cornerRadius = 60 / 2.0;
        m_arYellow.layer.borderColor = [UIColor blackColor].CGColor;
        m_arYellow.layer.borderWidth = 1;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    switch (lighting)
    {
        case red:
            [m_arRed setBackgroundColor:[UIColor redColor]];
            [m_arGreen setBackgroundColor:[UIColor clearColor]];
            [m_arYellow setBackgroundColor:[UIColor clearColor]];
            lighted = red;
            lighting = yellow;
            break;
        case green:
            [m_arRed setBackgroundColor:[UIColor clearColor]];
            [m_arGreen setBackgroundColor:[UIColor greenColor]];
            [m_arYellow setBackgroundColor:[UIColor clearColor]];
            lighted = green;
            lighting = yellow;
            break;
        case yellow:
            [m_arRed setBackgroundColor:[UIColor clearColor]];
            [m_arGreen setBackgroundColor:[UIColor clearColor]];
            [m_arYellow setBackgroundColor:[UIColor yellowColor]];
            if (lighted == red)
            {
                lighting = green;
            }else
            {
                lighting = red;
            }
            break;
        default:
            [m_arRed setBackgroundColor:[UIColor redColor]];
            [m_arGreen setBackgroundColor:[UIColor clearColor]];
            [m_arYellow setBackgroundColor:[UIColor clearColor]];
            lighted = red;
            lighting = yellow;
            break;
    }
}

@end

@interface Test6ViewController ()
{
    MyView *myView;
}

@end

@implementation Test6ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    myView = [[MyView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(change:) userInfo:nil repeats:YES];
}

- (void)change:(NSTimer *)aTimer
{
    [myView setNeedsDisplay];
}

@end
