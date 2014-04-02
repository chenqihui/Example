//
//  LYDwaveform.m
//  波形图
//
//  Created by Dong on 14-3-14.
//  Copyright (c) 2014年 CNTV. All rights reserved.
//

#import "LYDwaveform.h"

@implementation LYDwaveform

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        i = 0;
        j = 0;
    }
    return self;
}

- (void)callDraw:(float)f
{
    if (f < 1) {
        swing = f;
    }else {
        swing = 1;
    }

    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    if (i > 55) {

        i = 0;
        j = 0;
    }

//    NSLog(@"%f",swing);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 2.0);

    CGContextMoveToPoint(context, -55+i, 40);
    CGContextAddCurveToPoint(context, -32.5+i, 30-(swing*20), -22.5+i, 50+(swing*20), 0+i, 40);

    CGContextMoveToPoint(context, 0+i, 40);
    CGContextAddCurveToPoint(context, 22.5+i, 30-(swing*(20+j)), 32.5+i, 50+(swing*(20+j)), 55+i, 40);

    CGContextMoveToPoint(context, 55+i, 40);
    CGContextAddCurveToPoint(context, 77.5+i, 30-(swing*80), 87.5+i, 50+(swing*80), 110+i, 40);

    CGContextMoveToPoint(context, 110+i, 40);
    CGContextAddCurveToPoint(context, 132.5+i, 30-(swing*(80-j)), 142.5+i, 50+(swing*(80-j)), 165+i, 40);

    CGContextMoveToPoint(context, 165+i, 40);
    CGContextAddCurveToPoint(context, 187.5+i, 30-(swing*20), 197.5+i, 50+(swing*20), 220+i, 40);
    CGContextStrokePath(context);

    i++;
    j = j+0.727;

}


@end
