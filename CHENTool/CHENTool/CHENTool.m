//
//  CHENTool.m
//  CHENTool
//
//  Created by chen on 13-9-9.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "CHENTool.h"

@implementation CHENTool

+ (void)speak:(NSString *)text
{
    NSLog(@"%@", text);
}

- (UIView *)addView:(CGRect)rect
{
    UIView *v = [[[UIView alloc] initWithFrame:rect] autorelease];
    [v setBackgroundColor:[UIColor blueColor]];
    return v;
}

@end
