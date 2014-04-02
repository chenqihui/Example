//
//  LYDwaveform.h
//  波形图
//
//  Created by Dong on 14-3-14.
//  Copyright (c) 2014年 CNTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYDwaveform : UIView
{
    float swing;
    int   i;
    float j;
}

- (void)callDraw:(float)f;

@end
