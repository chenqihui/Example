//
//  Test2ViewController.h
//  ShowChenTool
//
//  Created by chen on 13-10-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface Test2ViewController : UIViewController<AVAudioPlayerDelegate, UITextFieldDelegate>
{
    AVAudioPlayer *m_avaudioplayer;
}

@property (retain, nonatomic) IBOutlet UITextField *textField;

@property (retain, nonatomic) IBOutlet UILabel *showLabel;

- (IBAction)stopIt:(id)sender;

- (IBAction)sayIt:(id)sender;

- (IBAction)countCharIt:(id)sender;

@end
