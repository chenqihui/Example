//
//  UIView+UIViewExtend.h
//  TemporaryTest
//
//  Created by chen on 13-12-10.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewExtend)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat offsetX;
@property(nonatomic) CGFloat offsetY;

@property(nonatomic) CGSize size;

@property(nonatomic) CGPoint origin;

@property(nonatomic) CGFloat centerX;

@property(nonatomic) CGFloat centerY;

@end

@protocol UIViewExtendDelegate <NSObject>

@optional

@property(nonatomic, retain) NSString *szTag;

@end
