//
//  CViewBaseViewController+PanToPrevViewController.m
//  etionUI
//
//  Created by wjxfhxy on 13-7-30.
//  Copyright (c) 2013年 GuangZhouXuanWu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GestureRecognizerVcl.h"

typedef enum
{
    EPanToPrevVclMoveDirectionTypeNONE,
    EPanToPrevVclMoveDirectionTypeLeftToRight = 1,
    EPanToPrevVclMoveDirectionTypeRightToLeft = 2
} EPanToPrevVclMoveDirectionType;

@interface CPanToPrevVclGestureRecognizer : UIPanGestureRecognizer
{
    UIViewController *m_firstvcl;
    UIViewController *m_secondvcl;

    UIViewController *m_parentvcl;

    UIViewController *m_gesturevcl;

    UIView *m_mask;
    float m_nMaskalpha;

    BOOL m_bCatching;

    EPanToPrevVclMoveDirectionType m_nMovedirection;

    float m_nBeginx;
    float m_nMove;

    float m_nMaxmove;
    float m_nMinmove;

    float m_nZoomscale;

    id <GestureRecognizerVclDelegate> m_delegate;
    
    UIGestureRecognizerState m_transformstate;
}

@property(nonatomic, assign) UIViewController *m_firstvcl;
@property(nonatomic, assign) UIViewController *m_secondvcl;

@property(nonatomic, assign) UIViewController *m_gesturevcl;

@property(nonatomic, assign) UIViewController *m_parentvcl;

@property(nonatomic, assign) BOOL m_bCatching;

@property(nonatomic, assign) EPanToPrevVclMoveDirectionType m_nMovedirection;

@property(nonatomic, assign) float m_nBeginx;
@property(nonatomic, assign) float m_nMove;

@property(nonatomic, assign) float m_nMaxmove;
@property(nonatomic, assign) float m_nMinmove;

@property(nonatomic, assign) float m_nZoomscale;

@property(nonatomic, retain) UIView *m_mask;
@property(nonatomic, assign) float m_nMaskalpha;

@property(nonatomic, assign) id <GestureRecognizerVclDelegate> m_delegate;

@property(nonatomic, assign) UIGestureRecognizerState m_transformstate;

@end

@implementation CPanToPrevVclGestureRecognizer

@synthesize m_firstvcl;
@synthesize m_secondvcl;

@synthesize m_gesturevcl;

@synthesize m_parentvcl;

@synthesize m_bCatching;

@synthesize m_nMovedirection;

@synthesize m_nBeginx;
@synthesize m_nMove;

@synthesize m_nMaxmove;
@synthesize m_nMinmove;

@synthesize m_nZoomscale;

@synthesize m_mask;
@synthesize m_nMaskalpha;

@synthesize m_delegate;

@synthesize m_transformstate;

- (id)initWithTarget:(id)target action:(SEL)action
{
    [super initWithTarget:target action:action];

    m_nMinmove = 0;
    m_nMaxmove = [UIScreen mainScreen].applicationFrame.size.width;

    m_nZoomscale = 0.95;

    m_nMaskalpha = 0.8;
    
    m_transformstate=UIGestureRecognizerStatePossible;

    return self;
}

- (void)dealloc
{
    m_firstvcl = nil;
    m_secondvcl = nil;

    m_gesturevcl = nil;

    m_parentvcl = nil;

    [m_mask release];

    [super dealloc];
}


@end

@implementation GestureRecognizerViewController

- (void)InitPanToPrevViewController:(UIViewController *)parentvcl TransformDelegate:(id <GestureRecognizerVclDelegate>)delegate
{
    CPanToPrevVclGestureRecognizer *gr = [[[CPanToPrevVclGestureRecognizer alloc] initWithTarget:self action:@selector(PanToPrevGestureRecognizer:)] autorelease];
    gr.m_delegate = delegate;
    gr.m_gesturevcl = self;
    gr.delegate = self;
    gr.m_parentvcl = parentvcl;
    [self.view addGestureRecognizer:gr];
}

- (void)InitPanToPrevViewController:(UIViewController *)parentvcl
{
    [self InitPanToPrevViewController:parentvcl TransformDelegate:nil];
}

- (BOOL)VclCanPanToPrevVcl
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    if ([gestureRecognizer isMemberOfClass:[CPanToPrevVclGestureRecognizer class]] == YES)
//    {
//        CPanToPrevVclGestureRecognizer *gr = (CPanToPrevVclGestureRecognizer *) gestureRecognizer;
//
//        CGPoint p = [gr.view.superview convertPoint:gr.view.frame.origin fromView:[CViewBaseViewController GetRootViewController].view];
//        if ((p.x == 0 || gr.m_bCatching == YES) && [gr.m_gesturevcl VclCanPanToPrevVcl])
//        {
//            NSLog(@"CPanToPrevVclGestureRecognizer1");
//
//            return YES;
//        }
//    }
    return NO;
}

/*
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    NSLog(@"%d",((CPanToPrevVclGestureRecognizer *) gestureRecognizer).m_bCatching);
//    
//    float nX = [gestureRecognizer locationInView:((CPanToPrevVclGestureRecognizer *) gestureRecognizer).m_parentvcl.view].x;
//    
//    NSLog(@"%f",nX);
//    
//    if ([gestureRecognizer isMemberOfClass:[CPanToPrevVclGestureRecognizer class]] == YES)
//    {
//        if (((CPanToPrevVclGestureRecognizer *) gestureRecognizer).m_bCatching == YES)
//            return NO;
//    }
    return YES;
}
*/

- (void)PanToPrevGestureRecognizer:(CPanToPrevVclGestureRecognizer *)gr
{
//    switch ((int) gr.state)
//    {
//        case UIGestureRecognizerStateBegan:
//        {
//            gr.m_nBeginx = [gr locationInView:gr.m_parentvcl.view].x;
//            gr.m_nMove = gr.m_nBeginx;
//
//            break;
//        }
//        case UIGestureRecognizerStateChanged:
//        {
//            float nX = [gr locationInView:gr.m_parentvcl.view].x;
//
//            float nMove = nX - gr.m_nMove;
//
//            if (nMove == 0)
//                return;
//
//            gr.m_nMove = nX;
//
//            if (nX > gr.m_nBeginx && gr.m_bCatching == NO)
//            {
//                gr.m_bCatching = YES;
//
//                NSArray *arSubviews = gr.m_parentvcl.view.subviews;
//                for (int i = arSubviews.count - 1; i >= 0; i--)
//                {
//                    UIView *v = [arSubviews objectAtIndex:i];
//                    UIViewController *vcl = [CViewBaseViewController FindViewController:v];
//                    if (vcl != nil)
//                    {
//                        gr.m_firstvcl = vcl;
//
//                        for (int j = i - 1; j >= 0; j--)
//                        {
//                            UIView *v = [arSubviews objectAtIndex:j];
//                            UIViewController *vcl = [CViewBaseViewController FindViewController:v];
//                            if (vcl != nil)
//                                gr.m_secondvcl = vcl;
//                            break;
//                        }
//
//                        break;
//                    }
//                }
//                if (gr.m_firstvcl != nil&& gr.m_secondvcl != nil)
//                {
//                    if(gr.m_transformstate==UIGestureRecognizerStateChanged)
//                    {
//                        gr.m_transformstate=UIGestureRecognizerStateEnded;
//                        [gr.m_delegate PanToPrevVclGestureRecognizerTransformState:gr.m_transformstate GestureRecognizer:gr];
//                        gr.m_transformstate=UIGestureRecognizerStatePossible;
//                    }
//                    
//                    CGRect frame = gr.m_firstvcl.view.bounds;
//                    frame.origin.x -= 2;
//                    frame.size.width += 2;
//                    frame.origin.y = 0;
//                    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
//                    gr.m_firstvcl.view.layer.shadowPath = path.CGPath;
//                    gr.m_firstvcl.view.layer.shadowOpacity = 0.5;
//                    gr.m_firstvcl.view.layer.shadowOffset = CGSizeMake(0, 0);
//
//                    gr.m_mask = [[[UIView alloc] initWithFrame:gr.m_secondvcl.view.bounds] autorelease];
//                    [gr.m_secondvcl.view addSubview:gr.m_mask];
//
//                    gr.m_secondvcl.view.frame = gr.m_firstvcl.view.frame;
//                    gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(gr.m_nZoomscale, gr.m_nZoomscale);
//
//                    //   [gr.m_firstvcl ViewWillMoveCenterToRight];
//                    [gr.m_secondvcl ViewWillMoveLeftToCenter];
//                }
//            }
//
//            if ((gr.m_firstvcl == nil&& gr.m_secondvcl == nil) || gr.m_bCatching == NO)
//            {
//                if(gr.m_transformstate==UIGestureRecognizerStatePossible)
//                    gr.m_transformstate=UIGestureRecognizerStateBegan;
//                else if(gr.m_transformstate==UIGestureRecognizerStateBegan)
//                    gr.m_transformstate=UIGestureRecognizerStateChanged;
//                [gr.m_delegate PanToPrevVclGestureRecognizerTransformState:gr.m_transformstate GestureRecognizer:gr];
//
//                return;
//            }
//
//            if (nMove > 0)
//                gr.m_nMovedirection = EPanToPrevVclMoveDirectionTypeLeftToRight;
//            else if (nMove < 0)
//                gr.m_nMovedirection = EPanToPrevVclMoveDirectionTypeRightToLeft;
//
//            if (gr.m_firstvcl.view.left + nMove > 0)
//            {
//                if (gr.m_nMovedirection == EPanToPrevVclMoveDirectionTypeLeftToRight)
//                {
//                    if (gr.m_firstvcl.view.left >= gr.m_nMaxmove)
//                        return;
//
//                    if (gr.m_firstvcl.view.left + nMove > gr.m_nMaxmove)
//                        gr.m_firstvcl.view.left = gr.m_nMaxmove;
//                    else
//                        gr.m_firstvcl.view.left += nMove;
//                }
//                else if (gr.m_nMovedirection == EPanToPrevVclMoveDirectionTypeRightToLeft)
//                {
//                    if (gr.m_firstvcl.view.left <= gr.m_nMinmove)
//                        return;
//
//                    if (gr.m_firstvcl.view.left + nMove < gr.m_nMinmove)
//                        gr.m_firstvcl.view.left = gr.m_nMinmove;
//                    else
//                        gr.m_firstvcl.view.left += nMove;
//                }
//
//                if (gr.m_nMovedirection == EPanToPrevVclMoveDirectionTypeLeftToRight)
//                {
//                    float n = (1 - gr.m_nZoomscale) / gr.m_nMaxmove;
//                    n = n * gr.m_firstvcl.view.left;
//                    gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(gr.m_nZoomscale + n, gr.m_nZoomscale + n);
//
//                } else if (gr.m_nMovedirection == EPanToPrevVclMoveDirectionTypeRightToLeft)
//                {
//                    float n = (1 - gr.m_nZoomscale) / gr.m_nMaxmove;
//                    n = n * (gr.m_firstvcl.view.left - gr.m_nMaxmove);
//                    gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(1 + n, 1 + n);
//                }
//
//                if (gr.m_nMovedirection == EPanToPrevVclMoveDirectionTypeLeftToRight)
//                {
//                    float n = gr.m_nMaskalpha / gr.m_nMaxmove;
//                    n = n * ABS(gr.m_firstvcl.view.left);
//                    gr.m_mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:gr.m_nMaskalpha - n];
//
//                } else if (gr.m_nMovedirection == EPanToPrevVclMoveDirectionTypeRightToLeft)
//                {
//                    float n = gr.m_nMaskalpha / gr.m_nMaxmove;
//                    n = n * ABS(ABS(gr.m_firstvcl.view.left) - gr.m_nMaxmove);
//                    gr.m_mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:n];
//                }
//            }
//            else if (gr.m_firstvcl.view.left + nMove == 0)
//            {
//                gr.m_firstvcl.view.left = 0;
//                //    gr.m_firstvcl.view.layer.shadowPath = NULL;
//
//                gr.m_secondvcl.view.left = -gr.m_firstvcl.view.width;
//                gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(1, 1);
//
//                [gr.m_mask removeFromSuperview];
//                gr.m_mask = nil;
//                gr.m_bCatching = NO;
//                gr.m_firstvcl = nil;
//                gr.m_secondvcl = nil;
//            }
//            else if (gr.m_firstvcl.view.left + nMove < 0)
//            {
//                return;
//            }
//
//            break;
//        }
//        case UIGestureRecognizerStateEnded:
//        case UIGestureRecognizerStateCancelled:
//        case UIGestureRecognizerStateFailed:
//        {
//            if(gr.m_transformstate==UIGestureRecognizerStateChanged)
//            {
//                gr.m_transformstate=UIGestureRecognizerStateEnded;
//                [gr.m_delegate PanToPrevVclGestureRecognizerTransformState:gr.m_transformstate GestureRecognizer:gr];
//                gr.m_transformstate=UIGestureRecognizerStatePossible;
//            }
//            
//            gr.m_parentvcl.view.userInteractionEnabled = NO;
//
//            if (gr.m_firstvcl.view.left >= 20)
//            {
//                [gr.m_firstvcl ViewWillMoveCenterToRight];
//
//                [UIView animateWithDuration:0.3 animations:^
//                {
//                    gr.m_mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//                    gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(1, 1);
//                    gr.m_firstvcl.view.left = gr.m_firstvcl.view.width;
//
//
//                }                completion:^(BOOL finished)
//                {
//                    gr.m_firstvcl.view.layer.shadowPath = NULL;
//
//                    gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(1, 1);
//                    gr.m_parentvcl.view.userInteractionEnabled = YES;
//
//                    [gr.m_secondvcl ViewDidMoveLeftToCenter];
//
//                    [gr.m_firstvcl ViewDidMoveCenterToRight];
//                    [gr.m_firstvcl.view removeFromSuperview];
//                    [gr.m_firstvcl release];
//
//                    [gr.m_mask removeFromSuperview];
//                    gr.m_mask = nil;
//                    gr.m_bCatching = NO;
//                    gr.m_firstvcl = nil;
//                    gr.m_secondvcl = nil;
//                }];
//            }
//            else
//            {
//                [UIView animateWithDuration:0.3 animations:^
//                {
//                    gr.m_mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:gr.m_nMaskalpha];
//                    gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(gr.m_nZoomscale, gr.m_nZoomscale);
//                    gr.m_firstvcl.view.left = 0;
//
//                }                completion:^(BOOL finished)
//                {
//                    gr.m_firstvcl.view.layer.shadowPath = NULL;
//
//                    gr.m_secondvcl.view.left = -gr.m_firstvcl.view.width;
//                    gr.m_secondvcl.view.transform = CGAffineTransformMakeScale(1, 1);
//                    gr.m_parentvcl.view.userInteractionEnabled = YES;
//
//                    [gr.m_secondvcl ViewDidMoveCenterToLeft];
//
//                    [gr.m_mask removeFromSuperview];
//                    gr.m_mask = nil;
//                    gr.m_bCatching = NO;
//                    gr.m_firstvcl = nil;
//                    gr.m_secondvcl = nil;
//                }];
//            }
//
//            break;
//        }
//    }
}

@end
