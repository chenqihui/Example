//
//  OperatePlistFile.h
//  CHENTool
//
//  Created by chen on 13-9-11.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperatePlistFile : NSObject

- (void)read:(NSString *)filename typeDate:(id *)data;

- (void)read:(NSString *)filename typeClassDate:(NSString *)class complete:(void(^)(id data))complete;

- (void)read2:(NSString *)filename typeClassDate:(NSString *)class complete:(NSString*(^)(id data))complete;

- (void)set;

@end
