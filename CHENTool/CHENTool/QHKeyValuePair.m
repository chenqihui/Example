//
//  KeyValuePair.m
//  CHENTool
//
//  Created by chen on 13-10-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "QHKeyValuePair.h"

@implementation QHKeyValuePair

@synthesize m_value, m_key;

- (void)dealloc
{
    [m_value release];
    [m_key release];
    [super dealloc];
}

+ (QHKeyValuePair *)initWithValue:(id)value key:(id)key
{
    QHKeyValuePair *keyValuePair = [[QHKeyValuePair new] autorelease];
    keyValuePair.m_key = key;
    keyValuePair.m_value = value;
    
    return keyValuePair;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\"%@:%@\"", m_key, m_value];
}

+ (QHKeyValuePair *)initNSNull
{
    QHKeyValuePair *keyValuePair = [[QHKeyValuePair new] autorelease];
    keyValuePair.m_key = [NSNull null];
    keyValuePair.m_value = [NSNull null];
    
    return keyValuePair;
}

@end
