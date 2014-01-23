//
//  Test7ViewController.m
//  ShowChenTool
//
//  Created by chen on 14-1-23.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "Test7ViewController.h"

@interface Test7ViewController ()

@end

@implementation Test7ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //小菜和大鸟的编程故事之一：活字印刷-面向对象思想的先驱
    NSString *result = [self compute1];
    
    NSLog(@"%@", result);
}

- (NSString *)compute1
{
    //小菜和大鸟的编程故事之二：面试中代码无错就够了吗？
    /*
     大鸟说：“且先不说出题人的意思，单就你现在的代码，就有很多不足的地方需要改进。
     比如变量命名，
     1、你的命名就是ABCD，变量不带有任何具体含义，这是非常不规范的；
     2、判断分支，你这样的写法，意味着每个条件都要做判断，等于计算机做了三次无用功；
     3、数据输入有效性判断等，如果用户输入的是字符符号而不是数字怎么办？
     3、如果除数时，客户输入了0怎么办？
     这些都是可以改进的地方。”
     */
    NSString *A = @"1";
    
    NSString *B = @"+";
    
    NSString *C = @"2";
    
    NSString *D;
    int d = 0;
    if ([B isEqualToString:@"+"])
        d = [A intValue] + [C intValue];
    if ([B isEqualToString:@"-"])
        d = [A intValue] - [C intValue];
    if ([B isEqualToString:@"*"])
        d = [A intValue] * [C intValue];
    if ([B isEqualToString:@"/"])
        d = [A intValue] / [C intValue];
    D = [NSString stringWithFormat:@"%d", d];
    
    return D;
}

- (NSString *)compute2
{
//    NSString *B = @"+";
//    switch (B) {
//        case @"+":
//            
//            break;
//            
//        default:
//            break;
//    }
    return nil;
}

@end
