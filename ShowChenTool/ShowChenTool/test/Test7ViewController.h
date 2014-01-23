//
//  Test7ViewController.h
//  ShowChenTool
//
//  Created by chen on 14-1-23.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    none = 0,
    add = 1,
    minus = 2,
    multiply,
    divide
}OperateTag;

@interface Test7ViewController : UIViewController

@end

@interface Operation : NSObject

- (int)GetResult:(NSString *)strNumberA b:(NSString *)strNumberB o:(NSString *)strOperate;

@end

/*
 小菜：“哦，你的意思是，我应该把加减乘除等运算分离，修改其中一个不影响另外的几个，增加运算算法也不影响其它代码，是这样吗？”
 
 大鸟：“自己想去吧，如何用继承和多态，你应该有感觉了。”
 */
@interface OperationObj : NSObject

@property (nonatomic, assign) int NumberA;

@property (nonatomic, assign) int NumberB;

@property (nonatomic, assign) NSString *strOperate;

- (void)setA:(NSString *)strNumberA b:(NSString *)strNumberB o:(NSString *)operate;

- (int)GetResult;

@end

@interface OperationAdd : OperationObj

@end

@interface OperationSub : OperationObj

@end

@interface OperationMul : OperationObj

@end

@interface OperationDiv : OperationObj

@end

@interface OperationFactory : NSObject

+ (OperationObj *)createOperate:(NSString *)operate;

@end
