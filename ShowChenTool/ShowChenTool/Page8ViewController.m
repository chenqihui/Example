//
//  Page8ViewController.m
//  ShowChenTool
//
//  Created by chen on 14-4-2.
//  Copyright (c) 2014年 User. All rights reserved.
//

#import "Page8ViewController.h"

#define ANGLE(a) ((2*M_PI)/360)*a

@implementation CView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initAttributes];
    }
    return self;
}

- (void)initAttributes
{
    // animation duration
    _animationDuration = 0.5;
    
    // path array
    _paths = [[NSMutableArray new] retain];
    
    _coverWidth = 2.0;
    _fillCoverWidth = 2.0;
    
    _animatingLayer = [CAShapeLayer layer];
    _animatingLayer.frame = self.bounds;
    [self.layer addSublayer:_animatingLayer];
}

- (void)loadIndicator
{
    // set the initial Path
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    UIBezierPath *initialPath = [UIBezierPath bezierPath]; //empty path
    
    [initialPath addArcWithCenter:center radius:(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)))/2 - _coverWidth - _fillCoverWidth startAngle:degreeToRadian(-90) endAngle:degreeToRadian(270) clockwise:YES]; //add the arc
    
    _animatingLayer.path = initialPath.CGPath;
    _animatingLayer.strokeColor = [UIColor redColor].CGColor;
    _animatingLayer.fillColor = [UIColor clearColor].CGColor;
    _animatingLayer.lineWidth = _fillCoverWidth;
    _lastSourceAngle = degreeToRadian(-90);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [[UIColor redColor] set];
//    //画矩形
//    float width = self.bounds.size.width/4;
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect rectt = CGRectMake(width*3/2, width*3/2, width, width);
//    CGContextBeginPath(context);
//    CGContextAddRect(context, rectt);
//    CGContextClosePath(context);
//    CGContextFillRect(context, rectt);
    
//    //画圈
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 1);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), CGRectGetWidth(self.bounds)/2 - 1, ANGLE(0), ANGLE(350), 0);
//    CGContextStrokePath(context);
    
    //画圈2
    CGFloat radius = (MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2) - _coverWidth;
    
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    UIBezierPath *coverPath = [UIBezierPath bezierPath]; //empty path
    [coverPath setLineWidth:1];
    [coverPath addArcWithCenter:center radius:radius startAngle:0 endAngle:2*M_PI clockwise:YES]; //add the arc
    [[UIColor blueColor] set];
    [coverPath setLineWidth:_coverWidth];
    [coverPath stroke];
    
    
}

- (void)updateWithTotalBytesProgress:(float)nProgress
{
    _lastUpdatedPath = [UIBezierPath bezierPathWithCGPath:_animatingLayer.path];
    
    [_paths removeAllObjects];
    
    CGFloat destinationAngle = [self destinationAngleForRatio:nProgress];
    //radius旋转的半径
    CGFloat radius = (MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2) - _coverWidth - _fillCoverWidth;
    [_paths addObjectsFromArray:[self keyframePathsWithDuration:self.animationDuration lastUpdatedAngle:self.lastSourceAngle newAngle:destinationAngle radius:radius]];
    
    _animatingLayer.path = (__bridge CGPathRef)((id)_paths[(_paths.count -1)]);
    _lastSourceAngle = destinationAngle;
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    [pathAnimation setValues:_paths];
    [pathAnimation setDuration:self.animationDuration];
    [pathAnimation setRemovedOnCompletion:YES];
    [_animatingLayer addAnimation:pathAnimation forKey:@"path"];
}

- (CGFloat)destinationAngleForRatio:(CGFloat)ratio
{
    NSLog(@"-->%f", (360*ratio) - 90);
    NSLog(@"degreeToRadian-->%f", (degreeToRadian((360*ratio) - 90)));
    NSLog(@"ANGLE-->%f", (ANGLE((360*ratio) - 90)));
    NSLog(@"ANGLE2-->%f", (2 * M_PI / 360 * 270));
    return (degreeToRadian((360*ratio) - 90));
}

float degreeToRadian(float degree)
{
    return ((degree * M_PI)/180.0f);
}

#pragma mark Helper Methods
- (NSArray *)keyframePathsWithDuration:(CGFloat)duration lastUpdatedAngle:(CGFloat)lastUpdatedAngle newAngle:(CGFloat)newAngle radius:(CGFloat)radius
{
    NSUInteger frameCount = ceil(duration * 60);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:frameCount + 1];
    for (int frame = 0; frame <= frameCount; frame++)
    {
        CGFloat startAngle = ANGLE(-90);
        CGFloat endAngle = lastUpdatedAngle + (((newAngle - lastUpdatedAngle) * frame) / frameCount);
        
        [array addObject:(id)([self pathWithStartAngle:startAngle endAngle:endAngle radius:radius].CGPath)];
    }
    
    return [NSArray arrayWithArray:array];
}

- (UIBezierPath *)pathWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle radius:(CGFloat)radius
{
    BOOL clockwise = startAngle < endAngle;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    
    return path;
}

- (void)startRotateAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.duration = 1.f;
    animation.repeatCount = INT_MAX;
    
    [self.layer addAnimation:animation forKey:@"keyFrameAnimation"];
}

@end

@interface Page8ViewController ()
{
    UITextField *_textField;
    
    LYDwaveform *view;
    NSTimer *_timer;
}

@end

@implementation Page8ViewController

- (void)dealloc
{
    [_textField release];
    
    [view release];
    [_timer release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
	// Do any additional setup after loading the view.
    
//    CView *view = [[CView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:view];
//    
//    [view loadIndicator];
//    [view updateWithTotalBytesProgress:1];
    
//    [view startRotateAnimation];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 100, 30)];
    [_textField setText:@"textField"];
    [self.view addSubview:_textField];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn setFrame:CGRectMake(10, _textField.frame.origin.y + _textField.frame.size.height + 5, 30, 30)];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchDown];
    
    view = [[LYDwaveform alloc] initWithFrame:CGRectMake(50, 200, 220, 80)];
    view.backgroundColor = [UIColor redColor];
    view.clipsToBounds = YES;
    [self.view addSubview:view];
    //设置定时检测
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    
    UIButton *open = [UIButton buttonWithType:UIButtonTypeCustom];
    open.frame = CGRectMake(140, 350, 40, 20);
    [open setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [open setTitle:@"暂停" forState:UIControlStateNormal];
    [open setTitle:@"开始" forState:UIControlStateSelected];
    [open addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:open];
}

- (void)backButton:(UIButton *)btn
{
    if (btn.selected)
    {
        //开启定时器
        [_timer setFireDate:[NSDate distantPast]];
    }else
    {
        //关闭定时器
        [_timer setFireDate:[NSDate distantFuture]];
    }
    [btn setSelected:!btn.selected];
}

- (void)detectionVoice
{
    
    [view callDraw:1];
}

- (void)start
{
    [_textField.layer removeAnimationForKey:@"keyFrame"];
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGFloat y = _textField.layer.position.y;
    
    CGFloat x = _textField.layer.position.x;
    
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(x, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x - 10, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x + 10, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x - 10, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x + 10, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x - 10, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x + 10, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x - 10, y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(x, y)]];
    
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    keyFrame.duration = 1;
    
    _textField.layer.position = CGPointMake(x, y);
    
    [_textField.layer addAnimation:keyFrame forKey:@"keyFrame"];
}

@end
