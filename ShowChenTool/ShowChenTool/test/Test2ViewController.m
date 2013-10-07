//
//  Test2ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-10-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
}

- (void)dealloc
{
    [_textField release];
    [_showLabel release];
    [super dealloc];
}
- (IBAction)stopIt:(id)sender
{
}

- (IBAction)sayIt:(id)sender
{
    if(m_avaudioplayer != nil)
    {
        m_avaudioplayer.delegate=nil;
        [m_avaudioplayer stop];
        [m_avaudioplayer release];
        m_avaudioplayer=nil;
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
    }
    
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
//    NSData *data = [[NSData alloc] initWithBase64Encoding:@"我好喜欢你"];
    NSData *data = [@"我好喜欢你" dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    m_avaudioplayer=[[AVAudioPlayer alloc] initWithData:data error:&error];
    if (error != nil)
    {
        int errorCode = CFSwapInt32HostToBig ([error code]);
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
    }
    m_avaudioplayer.delegate=self;
    m_avaudioplayer.numberOfLoops=0;
    [m_avaudioplayer play];
}

- (IBAction)countCharIt:(id)sender
{
    NSString *tempStr = _textField.text;
    if (tempStr != nil && tempStr.length > 0)
    {
        tempStr = [NSString stringWithFormat:@"This is only a test has %d characters", tempStr.length];
    }
    _showLabel.text = tempStr;
}

#pragma UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_textField isFirstResponder])
    {
        [_textField resignFirstResponder];
    }
    return NO;
}

@end
