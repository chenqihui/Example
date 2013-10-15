//
//  QHQueueDictionary.h
//  CHENTool
//
//  Created by chen on 13-10-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QHKeyValuePair.h"

@interface QHQueueDictionary : NSObject
{
    NSMutableArray *m_arQueue;
    
    Class m_storecls;
}

@property(nonatomic, readonly) NSMutableArray *m_arQueue;
@property(nonatomic, readonly) Class m_storecls;

//1、基本操作
- (id)initWithStoreClass:(Class)cls;

- (NSUInteger)count;

#pragma mark add
- (void)addKeyValuePair:(id)aKeyValuePair;

//key可重复
- (void)addVlaue:(id)value key:(id)key;
//key不可重复，重复添加会覆盖前一个，相当于更新
- (void)setValue:(id)value forKey:(id)key;

- (BOOL)insertKeyValuePairAtIndex:(NSUInteger)index withKeyValuePair:(id)aKeyValuePair;

#pragma mark remove
- (void)removeAllKeyValuePairs;

- (void)removeKeyValuePairsForKeys:(NSArray *)keyArray;

- (void)removeLastKeyValuePair;

- (BOOL)removeKeyValuePairAtIndex:(NSUInteger)index;

- (NSUInteger)removeKeyValuePairForKey:(id)aKey;

- (void)removeKeyValuePair:(QHKeyValuePair *)keyValuePair;

#pragma mark update
//更新，找不到对应的key就更新为失败，返回false
- (BOOL)updateValue:(id)value forKey:(id)key;

- (BOOL)replaceKeyValuePairAtIndex:(NSUInteger)index withKeyValuePair:(id)aKeyValuePair;

- (BOOL)updateValue:(id)value atIndex:(NSUInteger)index;

- (BOOL)updateKey:(id)key atIndex:(NSUInteger)index;

#pragma mark get
- (QHKeyValuePair *)firstkeyValuePair NS_AVAILABLE(10_6, 4_0);

- (QHKeyValuePair *)lastkeyValuePair;

- (QHKeyValuePair *)keyValuePairForKey:(id)aKey;

- (QHKeyValuePair *)keyValuePairAtIndex:(NSUInteger)index;

- (id)getValueForKey:(id)key;

- (id)getValueForIndex:(NSUInteger)index;

- (id)getKeyForIndex:(NSUInteger)index;

- (NSMutableArray *)allKeys;

//2、转换NSDictionary和NSArray等ObjC的对象
#pragma mark
- (BOOL)addKeyValuePairsFromArrayKeyValuePair:(NSArray *)otherArray;

- (void)transformDictionaryToQHQueueDictionary:(NSMutableDictionary *)dic;

@end
