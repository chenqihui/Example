//
//  Test7ViewController.m
//  ShowChenTool
//
//  Created by chen on 14-1-23.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "Test7ViewController.h"

#define strNumberA @"1"

#define strOperate @"+"

#define strNumberB @"2"

@interface Test7ViewController ()

@end

@implementation Test7ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //小菜和大鸟的编程故事之一：活字印刷-面向对象思想的先驱
    /*
     “说说看，面向对象的四个好处？”
     “这个我记得最牢了，就是活字印刷那个例子啊，是可维护、可扩展、可复用和灵活性好。我知道了，可以把PC电脑理解成是大的软件系统，任何部件如CPU、内存、硬盘，显卡等都可以理解为程序中封装的类或程序集，由于PC易插拨的方式，那么不管哪一个出问题，都可以在不影响别的部件的前题下进行修改或替换。”
     “PC电脑里叫易插拨，面向对象里把这种关系叫什么？”
     “应该是叫强内聚、松耦合吧。”
     */
    NSString *result = [self compute6];
    
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

- (NSString *)compute5
{
    NSString *result = nil;
    
    //小菜和大鸟的编程故事之八：初识"策略模式"
    /*
     “策略模式”定义了算法家族，分别封装起来，让它们之间可以互相替换， 此模式让算法的变化， 不会影响到使用算法的客户。
    */
    /*
     这个模式涉及到三个角色：
     1、环境（Context）角色：持有一个Strategy类的引用。
     2、抽象策略（Strategy）角色：这是一个抽象角色，通常由一个接口或抽象类实现。此角色给出所有的具体策略类所需的接口。
     3、具体策略（ConcreteStrategy）角色：包装了相关的算法或行为。
     */
    int resultInt = 0;
    OperationContext *context = [[OperationContext new] autorelease];
    switch ([self switchInt:strOperate])
    {
        case add:
            context.oper = [[OperationAdd alloc] init];
            break;
        case minus:
            context.oper = [[OperationSub alloc] init];
            break;
        case multiply:
            context.oper = [[OperationMul alloc] init];
            break;
        case divide:
            context.oper = [[OperationDiv alloc] init];
            break;
            
        default:
            break;
    }
    [context.oper setA:strNumberA b:strNumberB o:strOperate];
    resultInt = context.GetResult;
    result = [NSString stringWithFormat:@"%d", resultInt];
    
    return result;
}

//小菜和大鸟的编程故事之九：反射--程序员的快乐
/*
 可以通过xml或者plist配置文件来实现界面对应的功能创建
 <?xml version="1.0" encoding="utf-8" ?>
 <CashAcceptType>
     <type>
         <name>+</name>
         <class>OperationAdd</class>
         <class>GetResult</class>
         <para></para>
     </type>
 </CashAcceptType>
 */
- (NSString *)compute6
{
    NSString *result = nil;
    int resultInt = 0;
//    OperationObj *obj = [[OperationAdd alloc] init];
    Class cls = NSClassFromString(@"OperationAdd");
    id obj = [[cls alloc] init];
    [obj setA:strNumberA b:strNumberB o:strOperate];
    SEL selector = NSSelectorFromString(@"GetResult");
    /*
     下面两段代码都在主线程中运行，我们在看别人代码时会发现有时会直接调用，有时会利用performSelector调用，今天看到有人在问这个问题，我便做一下总结，
     [delegate imageDownloader:self didFinishWithImage:image];
     [delegate performSelector:@selector(imageDownloader:didFinishWithImage:) withObject:self withObject:image];
     
     1、performSelector是运行时系统负责去找方法的，在编译时候不做任何校验；如果直接调用编译是会自动校验。如果imageDownloader：didFinishWithImage:image：不存在，那么直接调用 在编译时候就能够发现（借助Xcode可以写完就发现），但是使用performSelector的话一定是在运行时候才能发现（此时程序崩溃）；Cocoa支持在运行时向某个类添加方法，即方法编译时不存在，但是运行时候存在，这时候必然需要使用performSelector去调用。所以有时候如果使用了performSelector，为了程序的健壮性，会使用检查方法
     - (BOOL)respondsToSelector:(SEL)aSelector;
     2、直接调用方法时候，一定要在头文件中声明该方法的使用，也要将头文件import进来。而使用performSelector时候， 可以不用import头文件包含方法的对象，直接用performSelector调用即可。
     */
    resultInt = (int)[obj performSelector:selector withObject:nil];
    result = [NSString stringWithFormat:@"%d", resultInt];
    return result;
}

//小菜和大鸟的编程故事之十：会修电脑不会修收音机？--谈设计模式原则
/*
 设计模式
 “很好，你已经在无意的谈话间提到了设计模式其中的几大设计原则，
 1、单一职责原则，
 2、开放—封闭原则，
 3、依赖倒转原则（参考《敏捷软件开发——原则、模式与实践》）”
 大鸟接着讲道，“所谓单一职责原则，就是指就一个类而言，应该仅有一个引起它变化的原因，就刚才修电脑的事，显然内存坏了，不应该成为更换CPU的理由。开放—封闭原则是说对扩展开发，对修改关闭，通俗的讲，就是我们在设计一个模块的时候，应当使这个模块可以在不被修改的前提下被扩展，换句话说就是，应当可以在不必修改源代码的情况下改变这个模块的行为。比如内存不够只要插槽多就可以加，比如硬盘不够了，可以用移动硬盘等，PC的接口是有限的，所以扩展有限，软件系统设计得好，却可以无限的扩展。依赖倒转原则，原话解释是抽象不应该依赖细节，细节应该依赖于抽象，这话绕口，说白了，就是要针对接口编程，不要对实现编程，无论主板、CPU、内存、硬盘都是在针对接口编程，如果针对实现编程，那就会出现换内存需要把主板也换了的尴尬。你想在小MM面前表现也就不那么容易了。所以说，PC电脑硬件的发展，和面向对象思想发展是完全类似的。这也说明世间万物都是遵循某种类似的规律，谁先把握了这些规律，谁就最早成为了强者。”
 */
/*
 “收音机就是典型的耦合过度，只要收音机出故障，不管是声音没有、不能调频、有杂音，反正都很难修理，不懂的人根本没法修，因为任何问题都可能涉及其它部件。非常复杂的PC电脑可以修，反而相对简单的收音机不能修，这其实就说明了很大的问题。当然，电脑的所谓修也就是更换配件，CPU或内存要是坏了，老百姓是没法修的。其实现在在软件世界里，收音机式强耦合开发还是太多了，比如前段时间某银行出问题，需要服务器停机大半天的排查修整，这要损失多少钱。如果完全面向对象的设计，或许问题的查找和修改就容易得多。”
 “是的是的，我听说很多银行目前还是纯C语言的面向过程开发，非常不灵活，维护成本是很高昂的。”
 “那也是没办法的，银行系统哪是说换就换的，所以现在是大力鼓励年轻人学设计模式，直接面向对象的设计和编程，从大的方向上讲，这是国家大力发展生产力的很大保障呀。”
 */

//小菜和大鸟的编程故事之十一：三层架构 分层开发
/*
 三层架构或者分层开发说起来容易，在程序开发时的初学者还是有很多的误解。
 误区：
 1、DBServer-WebServer-Client是三层架构，其实这是物理意思上的三层架构，和程序的三层架构没有什么关系。
 2、WinForm界面的窗体或者WebForm的aspx是最上一层，它们对应的代码后置（codebehind）文件Form.cs或aspx.cs是第二层，然后再有一个访问数据库的代码，比如ado.cs或SqlHelper.cs是最下一层，这其实也是非常错误的理解。
 3、很多人认为MVC模式（Model-View-Controler）就是三层架构，这是比较经典的错误理解了。
 */
//所谓的三层开发，就是关于表现层、业务逻辑层和数据访问层的开发。

//小菜和大鸟的编程故事之十二：无熟人难办事？--聊设计模式之迪米特法则
/*
  “当然，这个原则也是满足的，不过我今天想讲的是另一个原则：‘迪米特法则（LoD）’ 也叫最少知识原则，
 简单的说，就是如果两个类不必彼此直接通信，那么这两个类就不应当发生直接的相互作用。如果其中一个类需要调用另一个类的某一个方法的话，可以通过第三者转发这个调用。其实道理就是你今天碰到的这个例子，你第一天去公司，怎么会认识IT部的人呢，如果公司有很好的管理，那么应该是人事的小杨打个电话到IT部，告诉主管安排人给小菜你装电脑，就算开始是小张负责，他临时有急事，主管也可以再安排小李来处理，如果小李当时不忙的话。其实迪米特法则还是在讲如何减少耦合的问题，类之间的耦合越弱，越有利于复用，一个处在弱耦合的类被修改，不会对有关系的类造成波及。也就是说，信息的隐藏促进了软件的复用。”
 */

//小菜和大鸟的编程故事之十三：门面让程序员的程序更加体面
/*
 门面模式要求一个子系统的外部与其内部的通信必须通过一个统一的门面(Facade)对象进行。门面模式提供一个高层次的接口，使得子系统更易于使用。
 
 门面模式的结构
 1、门面(Facade)角色：客户端可以调用这个角色的方法。此角色知晓相关的(一个或者多个)子系统的功能和责任。在正常情况下，本角色会将所有从客户端发来的请求委派到相应的子系统去。
 2、子系统(subsystem)角色：可以同时有一个或者多个子系统。每一个子系统都不是一个单独的类，而是一个类的集合。每一个子系统都可以被客户端直接调用，或者被门面角色调用。子系统并不知道门面的存在，对于子系统而言，门面仅仅是另外一个客户端而已。
 */

@end

//封装
@implementation Operation

- (int)GetResult:(NSString *)sNumberA b:(NSString *)sNumberB o:(NSString *)sOperate
{
    int resultInt = 0;
    switch ([self switchInt:sOperate])
    {
        case add:
            resultInt = [sNumberA intValue] + [sNumberB intValue];
            break;
        case minus:
            resultInt = [sNumberA intValue] - [sNumberB intValue];
            break;
        case multiply:
            resultInt = [sNumberA intValue] * [sNumberB intValue];
            break;
        case divide:
            resultInt = [sNumberA intValue] / [sNumberB intValue];
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
@synthesize Operate = _Operate;

- (void)dealloc
{
    [_Operate release];
    [super dealloc];
}

- (void)setA:(NSString *)sNumberA b:(NSString *)sNumberB o:(NSString *)operate
{
    _NumberA = [sNumberA intValue];
    _NumberB = [sNumberB intValue];
    _Operate = [operate retain];
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

//环境
@implementation OperationContext

@synthesize oper;

- (int)GetResult
{
    return oper.GetResult;
}

@end
