//
//  LotteryEntry.h
//  ShowChenTool
//
//  Created by chen on 13-10-2.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryEntry : NSObject
{
    NSDate *entryDate;
    int firstNumber;
    int secondNumber;
}

@property (nonatomic, retain) NSDate *entryDate;
@property (nonatomic, readonly) int firstNumber;
@property (nonatomic, readonly) int secondNumber;

- (void)prepareRandomNumbers;

@end
