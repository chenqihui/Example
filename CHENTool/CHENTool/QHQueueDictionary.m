//
//  QHQueueDictionary.m
//  CHENTool
//
//  Created by chen on 13-10-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "QHQueueDictionary.h"

@implementation QHQueueDictionary

@synthesize m_arQueue;
@synthesize m_storecls;

- (void)dealloc
{
    [m_arQueue release];
    [super dealloc];
}
//1、基本操作
- (id)init
{
    return [self initWithStoreClass:[QHKeyValuePair class]];
}

- (id)initWithStoreClass:(Class)cls
{
    [super init];
    
    m_arQueue = [NSMutableArray new];
    
    m_storecls = cls;
    
    return self;
}

- (NSUInteger)count
{
    return [m_arQueue count];
}

//add
- (void)addKeyValuePair:(id)aKeyValuePair
{
    [m_arQueue addObject:aKeyValuePair];
}

//key可重复
- (void)addVlaue:(id)value key:(id)key
{
    QHKeyValuePair *pair = [[m_storecls new] autorelease];
    pair.m_value = value;
    pair.m_key = key;
    [self addKeyValuePair:pair];
}

//key不可重复，重复添加会覆盖前一个，相当于更新
- (void)setValue:(id)value forKey:(id)key
{
    
}

- (BOOL)insertKeyValuePairAtIndex:(NSUInteger)index withKeyValuePair:(id)aKeyValuePair
{
    if ([m_arQueue count] == 0 || [m_arQueue count] - 1 < index)
    {
        for (int i = [m_arQueue count]; i < index; i++)
        {
            [m_arQueue addObject:[QHKeyValuePair initNSNull]];
        }
        [m_arQueue addObject:aKeyValuePair];
    }else
    {
        [m_arQueue insertObject:aKeyValuePair atIndex:index];
    }
    return NO;
}

//remove
- (void)removeAllKeyValuePairs
{
    [m_arQueue removeAllObjects];
}

- (void)removeKeyValuePairsForKeys:(NSArray *)keyArray
{
    [keyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        QHKeyValuePair *keyValuePair = [self keyValuePairForKey:obj];
        [self removeKeyValuePair:keyValuePair];
    }];
}

- (void)removeLastKeyValuePair
{
    [m_arQueue removeLastObject];
}

- (BOOL)removeKeyValuePairAtIndex:(NSUInteger)index
{
    if([m_arQueue count] - 1 < index)
        return NO;
    [m_arQueue removeObjectAtIndex:index];
    return YES;
}

- (NSUInteger)removeKeyValuePairForKey:(id)aKey
{
    for (int i = 0; i < [m_arQueue count]; i++)
    {
        QHKeyValuePair *keyValuePair = [m_arQueue objectAtIndex:i];
        if ([keyValuePair.m_key compare:aKey] == NSOrderedSame)
        {
            [m_arQueue removeObject:keyValuePair];
            return i;
        }
    }
    return NSNotFound;
}

- (void)removeKeyValuePair:(QHKeyValuePair *)keyValuePair
{
    [m_arQueue removeObject:keyValuePair];
}

//update
//更新，找不到对应的key就更新为失败，返回false
- (BOOL)updateValue:(id)value forKey:(id)key
{
    QHKeyValuePair *keyValuePair = [self keyValuePairForKey:key];
    keyValuePair.m_value = value;
    return YES;
}

- (BOOL)replaceKeyValuePairAtIndex:(NSUInteger)index withKeyValuePair:(id)aKeyValuePair
{
    QHKeyValuePair *keyValuePair = [self keyValuePairAtIndex:index];
    if (keyValuePair != nil)
    {
        [m_arQueue removeObjectAtIndex:index];
        [m_arQueue insertObject:aKeyValuePair atIndex:index];
        return YES;
    }
    return NO;
}

- (BOOL)updateValue:(id)value atIndex:(NSUInteger)index
{
    QHKeyValuePair *keyValuePair = [self keyValuePairAtIndex:index];
    if (keyValuePair != nil)
    {
        keyValuePair.m_value = value;
        return YES;
    }
    return NO;
}

- (BOOL)updateKey:(id)key atIndex:(NSUInteger)index
{
    QHKeyValuePair *keyValuePair = [self keyValuePairAtIndex:index];
    if (keyValuePair != nil)
    {
        keyValuePair.m_key = key;
        return YES;
    }
    return NO;
}

//get
- (QHKeyValuePair *)firstkeyValuePair NS_AVAILABLE(10_6, 4_0)
{
    return [m_arQueue firstObject];
}

- (QHKeyValuePair *)lastkeyValuePair
{
    return [m_arQueue lastObject];
}

- (QHKeyValuePair *)keyValuePairForKey:(id)aKey
{
    for (int i = 0; i < [m_arQueue count]; i++)
    {
        QHKeyValuePair *keyValuePair = [m_arQueue objectAtIndex:i];
        if ([keyValuePair.m_key compare:aKey] == NSOrderedSame)
        {
            return keyValuePair;
        }
    }
    return nil;
}

- (QHKeyValuePair *)keyValuePairAtIndex:(NSUInteger)index
{
    if ([m_arQueue count] - 1 >= index)
    {
        return [m_arQueue objectAtIndex:index];
    }
    return nil;
}

- (id)getValueForKey:(id)key
{
    QHKeyValuePair *keyValuePair = [self keyValuePairForKey:key];
    return keyValuePair == nil ? nil : keyValuePair.m_value;
}

- (id)getValueForIndex:(NSUInteger)index
{
    QHKeyValuePair *keyValuePair = (QHKeyValuePair *)[m_arQueue objectAtIndex:index];
    return keyValuePair == nil ? nil : keyValuePair.m_value;
}

- (id)getKeyForIndex:(NSUInteger)index
{
    QHKeyValuePair *keyValuePair = (QHKeyValuePair *)[m_arQueue objectAtIndex:index];
    return keyValuePair == nil ? nil : keyValuePair.m_key;
}

- (NSMutableArray *)allKeys
{
    NSMutableArray *ar = [[[NSMutableArray alloc] initWithCapacity:m_arQueue.count] autorelease];
    for (QHKeyValuePair *kv in m_arQueue)
        [ar addObject:kv.m_key];
    return ar;
}

//2、转换NSDictionary和NSArray等ObjC的对象

- (BOOL)addKeyValuePairsFromArrayKeyValuePair:(NSArray *)otherArray
{
    for (int i = 0; i < [m_arQueue count]; i++)
    {
        if (![[otherArray objectAtIndex:i] isMemberOfClass:[QHKeyValuePair class]])
            return NO;
    }
    [m_arQueue addObjectsFromArray:otherArray];
    return YES;
}

- (NSString *)description
{
    NSString *printf = [NSString stringWithFormat:@"[%d]:{", [self count]];
    for (QHKeyValuePair *keyValuePair in m_arQueue)
    {
        printf = [NSString stringWithFormat:@"%@\n%@,", printf, keyValuePair];
    }
    printf = [NSString stringWithFormat:@"%@\n}", printf];
    return printf;
}

- (void)transformDictionaryToQHQueueDictionary:(NSMutableDictionary *)dic
{
//    NSLog(@"%@", dic);
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [self addVlaue:obj key:key];
    }];
//    NSArray *arKeys = [dic allKeys];
//    NSMutableArray *arKeys = [[NSMutableArray new] autorelease];
//    for (int i = 0; i < [dic count]; i++)
//    {
//        id key = [arKeys objectAtIndex:i];
//        NSLog(@"%@", key);
//        [self addVlaue:[dic objectForKey:key] key:key];
//    }
}

@end
