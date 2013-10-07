//
//  KeyValuePair.h
//  CHENTool
//
//  Created by chen on 13-10-1.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QHKeyValuePair : NSObject
{
    id m_value;
    id m_key;
}

@property(nonatomic,retain) id m_value;
@property(nonatomic,retain) id m_key;

+ (QHKeyValuePair *)initWithValue:(id)value key:(id)key;

+ (QHKeyValuePair *)initNSNull;

@end
