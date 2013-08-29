//
//  BaiDuMapViewController.m
//  MyExampleTest
//
//  Created by chen on 13-8-28.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "BaiDuMapViewController.h"

#import "BMKMapManager.h"
#import "BMKMapView.h"

@interface BaiDuMapViewController ()<BMKMapViewDelegate>
{
    BMKMapManager* _mapManager;
    BMKMapView* _mapView;
}

@end

@implementation BaiDuMapViewController

- (void)dealloc
{
    [_mapManager release];
    [_mapView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"F8234da2cf59207ec0c76cfe972d8cca"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
        return;
    }
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = _mapView;
    [_mapView setShowsUserLocation:YES];
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation;
{
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}


@end
