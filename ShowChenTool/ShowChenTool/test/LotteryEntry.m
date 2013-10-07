//
//  LotteryEntry.m
//  ShowChenTool
//
//  Created by chen on 13-10-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "LotteryEntry.h"

#define yMdHmsS      @"yyyy-MM-dd HH:mm:ss.SSS"

#define yMdHms      @"yyyy-MM-dd HH:mm:ss"

#define yMdHm       @"yyyy-MM-dd HH:mm"

#define yMd       @"yyyy-MM-dd"

@implementation LotteryEntry

@synthesize entryDate;
@synthesize firstNumber, secondNumber;

- (void)dealloc
{
    NSLog(@"dealocation%@", self);
    [entryDate release];
    [super dealloc];
}

- (void)prepareRandomNumbers
{
    firstNumber = ((int)random() % 100) + 1;
    secondNumber = ((int)random() % 100) + 1;
}

- (NSString *)description
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeStyle:NSDateFormatterNoStyle];
    [df setDateStyle:NSDateFormatterMediumStyle];
    
    [df setDateFormat:yMd];
    NSString *result;
    result = [[NSString alloc] initWithFormat:@"%@ = %d and %d", [df stringFromDate:entryDate], firstNumber, secondNumber];
    [result autorelease];
    [df release];
    return result;
}

@end
