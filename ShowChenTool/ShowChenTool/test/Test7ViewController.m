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
    NSString *result = [self compute4];
    
    NSLog(@"结果：%@", result);
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

//小菜和大鸟的编程故事之三：代码规范和重构意识
- (NSString *)compute2
{
    NSString *strNumberA = @"1";
    
    NSString *strOperate = @"+";
    
    NSString *strNumberB = @"2";
    
    NSString *result;
    
    //小菜和大鸟的编程故事之四：抛弃复制 选择复用
    /*
     大鸟：“所有编程初学者都会有这样的问题，就是碰到问题就直觉的用计算机能够理解的逻辑来描述和表达待解决的问题及具体的求解过程。这其实是用计算机的方式去思考，比如计算器这个程序，先要求输入两个数和运算符号，然后根据运算符号判断选择如何运算，得到结果，这本身没有错，但这样的思维却使得我们的程序只为满足实现当前的需求，程序不容易维护，不容易扩展，更不容易复用。从而达不到高质量代码的要求。”
    */
    int resultInt = 0;
    switch ([self switchInt:strOperate])
    {
        case add:
            resultInt = [strNumberA intValue] + [strNumberB intValue];
            break;
        case minus:
            resultInt = [strNumberA intValue] - [strNumberB intValue];
            break;
        case multiply:
            resultInt = [strNumberA intValue] * [strNumberB intValue];
            break;
        case divide:
            resultInt = [strNumberA intValue] / [strNumberB intValue];
            break;
            
        default:
            break;
    }
    result = [NSString stringWithFormat:@"%d", resultInt];
    
    return result;
}

- (int)switchInt:(NSString *)operate
{
    int operateInt = none;
    if ([operate isEqualToString:@"+"])
        operateInt = add;
    else if ([operate isEqualToString:@"-"])
        operateInt = minus;
    else if ([operate isEqualToString:@"*"])
        operateInt = multiply;
    else if ([operate isEqualToString:@"/"])
        operateInt = divide;

    return operateInt;
}

- (NSString *)compute3
{
    NSString *strNumberA = @"1";
    
    NSString *strOperate = @"+";
    
    NSString *strNumberB = @"2";
    
    NSString *result;
    
    //小菜和大鸟的编程故事之五：业务和界面分离
    /*
     大鸟：“准确的说，就是让业务逻辑与界面逻辑分开，让它们之间的耦合度下降。只有分离开，才容易达到容易维护或扩展。”
     */
    Operation *operation = [[[Operation alloc] init] autorelease];
    int resultInt = [operation GetResult:strNumberA b:strNumberB o:strOperate];
    result = [NSString stringWithFormat:@"%d", resultInt];
    
    return result;
}

- (NSString *)compute4
{
    NSString *strNumberA = @"1";
    
    NSString *strOperate = @"+";
    
    NSString *strNumberB = @"2";
    
    NSString *result;
    
    //小菜和大鸟的编程故事之六：简单工厂模式之体验
    /*
     大鸟：“写得很不错吗，大大超出我的想象了，你现在的问题其实就是如何去实例化对象的问题，哈，今天心情不错，再教你一招‘简单工厂模式’，也就是说，到底要实例化谁，将来会不会增加实例化的对象（比如增加开根运算），这是很容易变化的地方，应该考虑用一个单独的类来做这个创造实例的过程，这就是工厂，来，我们看看这个类如何写。”
     */
    OperationObj *oper = [OperationFactory createOperate:strOperate];
    [oper setA:strNumberA b:strNumberB o:strOperate];
    int resultInt = [oper GetResult];
    result = [NSString stringWithFormat:@"%d", resultInt];
    
    return result;
}

@end

//封装
@implementation Operation

- (int)GetResult:(NSString *)strNumberA b:(NSString *)strNumberB o:(NSString *)strOperate
{
    int resultInt = 0;
    switch ([self switchInt:strOperate])
    {
        case add:
            resultInt = [strNumberA intValue] + [strNumberB intValue];
            break;
        case minus:
            resultInt = [strNumberA intValue] - [strNumberB intValue];
            break;
        case multiply:
            resultInt = [strNumberA intValue] * [strNumberB intValue];
            break;
        case divide:
            resultInt = [strNumberA intValue] / [strNumberB intValue];
            break;
            
        default:
            break;
    }
    return resultInt;
}

- (int)switchInt:(NSString *)operate
{
    int operateInt = none;
    if ([operate isEqualToString:@"+"])
        operateInt = add;
    else if ([operate isEqualToString:@"-"])
        operateInt = minus;
    else if ([operate isEqualToString:@"*"])
        operateInt = multiply;
    else if ([operate isEqualToString:@"/"])
        operateInt = divide;
    
    return operateInt;
}

@end

//继承和多态
@implementation OperationObj

@synthesize NumberA = _NumberA;
@synthesize NumberB = _NumberB;
@synthesize strOperate = _strOperate;

- (void)dealloc
{
    [_strOperate release];
    [super dealloc];
}

- (void)setA:(NSString *)strNumberA b:(NSString *)strNumberB o:(NSString *)operate
{
    _NumberA = [strNumberA intValue];
    _NumberB = [strNumberB intValue];
    _strOperate = [operate retain];
}

- (int)GetResult
{
    return 0;
}

@end

@implementation OperationAdd

- (int)GetResult
{
    return self.NumberA + self.NumberB;
}

@end

@implementation OperationSub

- (int)GetResult
{
    return self.NumberA - self.NumberB;
}

@end

@implementation OperationMul

- (int)GetResult
{
    return self.NumberA * self.NumberB;
}

@end

@implementation OperationDiv

- (int)GetResult
{
    return self.NumberA / self.NumberB;
}

@end

@implementation OperationFactory

+ (OperationObj *)createOperate:(NSString *)operate
{
    OperationObj *oper = nil;
    
    switch ([self switchInt:operate])
    {
        case add:
            oper = [[OperationAdd alloc] init];
            break;
        case minus:
            oper = [[OperationSub alloc] init];
            break;
        case multiply:
            oper = [[OperationMul alloc] init];
            break;
        case divide:
            oper = [[OperationDiv alloc] init];
            break;
            
        default:
            break;
    }
    return [oper autorelease];
}

+ (int)switchInt:(NSString *)operate
{
    int operateInt = none;
    if ([operate isEqualToString:@"+"])
        operateInt = add;
    else if ([operate isEqualToString:@"-"])
        operateInt = minus;
    else if ([operate isEqualToString:@"*"])
        operateInt = multiply;
    else if ([operate isEqualToString:@"/"])
        operateInt = divide;
    
    return operateInt;
}

@end
