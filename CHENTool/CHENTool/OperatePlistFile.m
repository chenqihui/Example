//
//  OperatePlistFile.m
//  CHENTool
//
//  Created by chen on 13-9-11.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "OperatePlistFile.h"

@implementation OperatePlistFile

- (void)read:(NSString *)filename typeDate:(id *)data
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    id tempData = nil;
    if([*data isKindOfClass:[NSArray class]]){
        tempData = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    }
    else{
        tempData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    *data = [tempData copy];
    [tempData release];
}

- (void)set
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"showToolListData" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    NSLog(@"ha:%@", data);
    
    [data addObject:@"haha"];
    
//    //添加一项内容
//    [data setObject:@"add some content" forKey:@"c_key"];
//    
//    //获取应用程序沙盒的Documents目录
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *plistPath1 = [paths objectAtIndex:0];
//    
//    //得到完整的文件名
//    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];
//    //输入写入
//    [data writeToFile:filename atomically:YES];
//    
//    //那怎么证明我的数据写入了呢？读出来看看
//    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
//    NSLog(@"%@", data1);
}

@end
