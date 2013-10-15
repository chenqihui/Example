//
//  Page3ViewController.m
//  ShowChenTool
//
//  Created by chen on 13-9-22.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "Page3ViewController.h"

@implementation MyEntityObject

@synthesize m_szName, m_szAddress, m_nAge;

- (void)dealloc
{
    [m_szName release];
    [m_szAddress release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        m_szName = @"1";
        m_szAddress = @"2";
        m_nAge = 100;
    }
    return self;
}

////属性变量分别转码
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.m_szName forKey:@"m_szName"];
//    [aCoder encodeObject:self.m_szAddress forKey:@"m_szAddress"];
//    [aCoder encodeObject:[NSNumber numberWithInt:self.m_nAge] forKey:@"m_nAge"];
//}
//
////分别把属性变量根据关键字进行逆转码，最后返回类的对象
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init])
//    {
//        self.m_szName = [aDecoder decodeObjectForKey:@"m_szName"];
//        self.m_szAddress = [aDecoder decodeObjectForKey:@"m_szAddress"];
//        self.m_nAge = [aDecoder decodeIntForKey:@"m_nAge"];
//    }
//    return self;
//}

@end

@interface Page3ViewController ()

@end

@implementation Page3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MyEntityObject *myEntityObj = [MyEntityObject new];
    ReflectPropertyValue *reflect = [ReflectPropertyValue new];
    NSMutableDictionary *dic = [[[reflect reflectDataFromOtherObject:myEntityObj] retain] autorelease];
    if (dic != nil) {
        NSLog(@"%@", dic);
    }
    
    NSMutableDictionary *dic1 = [[NSMutableDictionary new] autorelease];
    [dic1 setValue:@"91" forKey:@"m_szName"];
    [dic1 setValue:@"90" forKey:@"m_szAddress"];
    [dic1 setValue:[NSNumber numberWithInt:2] forKey:@"m_nAge"];
    BOOL b = [reflect reflectDataFromOtherObject2:myEntityObj data:dic1];
    if(b)
        NSLog(@"%@", myEntityObj);
}

@end
