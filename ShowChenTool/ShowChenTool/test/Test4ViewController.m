//
//  Test4ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-4.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Test4ViewController.h"

@implementation Model

@synthesize number;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self setValue:[NSNumber numberWithInt:5] forKey:@"fido"];
        NSNumber *n = [self valueForKey:@"fido"];
        NSLog(@"fido = %@", n);
        
        [self setValue:[NSNumber numberWithInt:5] forKey:@"number"];
    }
    return self;
}

- (int)fido
{
    NSLog(@"-fido is returning %d", fido);
    return fido;
}

- (void)setFido:(int)x
{
    NSLog(@"-setFido:is called with %d", x);
    fido = x;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:fido forKey:@"fido"];
    [aCoder encodeObject:number forKey:@"number"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        fido = [aDecoder decodeIntForKey:@"fido"];
        number = [aDecoder decodeObjectForKey:@"number"];
    }
    return self;
}

@end

@interface Test4ViewController ()

@end

@implementation Test4ViewController

@synthesize m;

- (void)dealloc
{
    [m release];
    [_m_slider release];
    [_m_showLabel release];
    [_chen release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    m = [[Model alloc] init];
    [_m_slider addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
}

- (void)change:(UISlider *)sender
{
    NSLog(@"%f", sender.value);
    _m_showLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    
    float f = sender.value * _m_slider.frame.size.width;
    _chen.center = CGPointMake(_m_slider.frame.origin.x + f, _chen.center.y);
}

@end
