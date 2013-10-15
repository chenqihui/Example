//
//  ReflectPropertyValue.h
//  CHENTool
//
//  Created by chen on 13-9-22.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReflectPropertyValue : NSObject

- (NSMutableDictionary *)reflectDataFromOtherObject:(id)dataSource;//传入个实体对象

- (BOOL)reflectDataFromOtherObject2:(id)dataSource data:(id)dic;

@end
