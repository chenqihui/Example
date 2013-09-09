//
//  CHENTool.h
//  CHENTool
//
//  Created by chen on 13-9-9.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CHENTool : NSObject

+ (void)speak:(NSString *)text;

- (UIView *)addView:(CGRect)rect;

@end
