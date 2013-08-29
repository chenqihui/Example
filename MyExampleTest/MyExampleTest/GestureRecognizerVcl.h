//
//  CViewBaseViewController+PanToPrevViewController.h
//  etionUI
//
//  Created by wjxfhxy on 13-7-30.
//  Copyright (c) 2013年 GuangZhouXuanWu. All rights reserved.
//

@protocol GestureRecognizerVclDelegate <NSObject>

//-(void)PanToPrevVclGestureRecognizerTransform:(UIGestureRecognizerState)state StartPoint:(CGPoint)startpoint LastMoved:(CGSize)loatmoved;

- (void)PanToPrevVclGestureRecognizerTransformState:(UIGestureRecognizerState)state GestureRecognizer:(UIGestureRecognizer*)gr;

@end

@interface GestureRecognizerViewController:UIViewController<UIGestureRecognizerDelegate>

- (void)InitPanToPrevViewController:(UIViewController *)parentvcl;

- (void)InitPanToPrevViewController:(UIViewController *)parentvcl TransformDelegate:(id<GestureRecognizerVclDelegate>)delegate;

- (BOOL)VclCanPanToPrevVcl;

@end
