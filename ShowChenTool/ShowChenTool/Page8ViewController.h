//
//  Page8ViewController.h
//  ShowChenTool
//
//  Created by chen on 14-4-2.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CView : UIView

@property(nonatomic, assign)CAShapeLayer *animatingLayer;
@property(nonatomic, assign)NSMutableArray *paths;

// the last updatedPath
@property(nonatomic, assign)UIBezierPath *lastUpdatedPath;
@property(nonatomic, assign)CGFloat lastSourceAngle;

// this the animation duration (default: 0.5)
@property(nonatomic, assign)CGFloat animationDuration;

// this applies to the covering stroke (default: 1)
@property(nonatomic, assign)CGFloat coverWidth;

// this applies to the covering stroke (default: 2)
@property(nonatomic, assign)CGFloat fillCoverWidth;

- (void)startRotateAnimation;

- (void)loadIndicator;

- (void)updateWithTotalBytesProgress:(float)nProgress;

@end

@interface Page8ViewController : UIViewController

@end
