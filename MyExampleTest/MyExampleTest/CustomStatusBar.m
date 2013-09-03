//
//  CustomStatusBar.m
//  MyExampleTest
//
//  Created by chen on 13-9-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "CustomStatusBar.h"

@implementation CustomStatusBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor blackColor];
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor blackColor];
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        _messageLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [_messageLabel setBackgroundColor:[UIColor clearColor]];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        [_messageLabel setTextColor:[UIColor whiteColor]];
        self.clipsToBounds = YES;
        [self addSubview:_messageLabel];
    }
    return self;
}

- (void)showStatusMessage:(NSString *)message
{
    self.hidden = NO;
    self.alpha = 1.0f;
    _messageLabel.text = @"";
    _messageLabel.text = message;
    
    CGSize totalSize = self.frame.size;
    self.frame = (CGRect){ self.frame.origin, {0, totalSize.height}};
    
    [UIView animateWithDuration:0.5f animations:^{
        self.frame = (CGRect){ self.frame.origin, totalSize };
    } completion:^(BOOL finished){
//        _messageLabel.text = message;
    }];
}

- (void)hide
{
    self.alpha = 1.0f;
    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished){
        _messageLabel.text = @"";
        self.hidden = YES;
    }];;
}

- (void)dealloc
{
    [_messageLabel release];
    [super dealloc];
}

@end
