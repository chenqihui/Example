//
//  TestOneViewController.m
//  MyExampleTest
//
//  Created by chen on 13-8-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "TestOneViewController.h"

@interface TestOneViewController ()
{
    UILabel *m_refresh;
    BOOL m_bRefreah;
    
    UILabel *m_view;
}

@end

@implementation TestOneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    CGSize s = [@"刷新" sizeWithFont:[UIFont systemFontOfSize:15]];
    m_refresh = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, s.width, s.height)];
    m_refresh.center = self.view.center;
    m_refresh.backgroundColor = [UIColor clearColor];
    m_refresh.font = [UIFont systemFontOfSize:15];
    m_refresh.text = @"刷新";
    
    [self.view addSubview:m_refresh];
    
    m_refresh.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickH:)];
    [m_refresh addGestureRecognizer:tapGestureTel];
    [tapGestureTel release];
    
    m_view = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
    [m_view setBackgroundColor:[UIColor whiteColor]];
    m_view.text = @"播放";
    [self.view addSubview:m_view];
    
    m_view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureTel2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTurn:)];
    [m_view addGestureRecognizer:tapGestureTel2];
    [tapGestureTel2 release];
    
}

- (void)dealloc
{
    [m_refresh release];
    [m_view release];
    [super dealloc];
}

- (void)clickH:(id)sender
{
    NSLog(@"refresh");
    m_bRefreah = !m_bRefreah;
    CABasicAnimation *a3 = nil;
    if (a3 == nil)
    {
        a3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        a3.fromValue = [NSNumber numberWithFloat:0.0];
        a3.toValue = [NSNumber numberWithFloat:M_PI * 2];
        //	a3.autoreverses = YES;
        a3.repeatCount = NSUIntegerMax;
        a3.duration = 2.0;
    }
    if(m_bRefreah)
    {
        [m_refresh.layer addAnimation:a3 forKey:@"z"];
    }
    else
    {
        [m_refresh.layer removeAnimationForKey:@"z"];
//        ((CAAnimation *)[m_refresh.layer animationForKey:@"z"]).autoreverses = YES;
    }
}

- (void)clickTurn:(id)sender
{
    m_bRefreah = !m_bRefreah;
    CABasicAnimation *a1 = nil;
    if (a1 == nil)
    {
        a1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
        a1.fromValue = [NSNumber numberWithFloat:0.0];
        a1.toValue = [NSNumber numberWithFloat:M_PI];
        //        a1.autoreverses = YES;
        //        a1.repeatCount = NSUIntegerMax;
        a1.duration = 1.0;
    }
    [m_view.layer addAnimation:a1 forKey:@"x"];
    if(m_bRefreah)
    {
        m_view.text = @"暂停";
    }
    else
    {
        m_view.text = @"开始";
    }
}

@end
