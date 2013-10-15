//
//  ReflectPropertyValue.m
//  CHENTool
//
//  Created by chen on 13-9-22.
//  Copyright (c) 2013年 User. All rights reserved.
//

/*
 /////使用方法
 NSDictionary *dicJsonData;
 EntityObject *objValue;
 [objValue reflectDataFromOtherObject:dicJsonData];//这样就可以完成对象的自动赋值了，
 
 //你还在使用
 objValue.value = [dicJsonData objectForKey:@"value"];//out了
 */

#import "ReflectPropertyValue.h"
#import <objc/message.h>

@implementation ReflectPropertyValue

- (NSArray*)propertyKeys:(id)dataSource
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([dataSource class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

- (NSMutableDictionary *)reflectDataFromOtherObject:(id)dataSource
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    BOOL ret = NO;
    for (NSString *key in [self propertyKeys:dataSource]) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [dic setObject:propertyValue forKey:key];
            }else
            {
                [dic setObject:[NSNull null] forKey:key];
            }
        }
    }
    return dic;
}

- (BOOL)reflectDataFromOtherObject2:(id)dataSource data:(id)dic
{
    BOOL ret = NO;
    for (NSString *key in [self propertyKeys:dataSource]) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            ret = ([dic valueForKey:key]==nil)?NO:YES;
        }
        else
        {
            ret = [dic respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dic valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [dataSource setValue:propertyValue forKey:key];
            }
        }
    }
    return ret;
}

- (void)setEflectDataFromOtherObject:(id)object data:(NSDictionary *)dic
{
    [self reflectDataFromOtherObject2:dic data:dic];//这样就可以完成对象的自动赋值了，
}

@end
