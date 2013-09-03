//
//  BaiDuMapViewController.m
//  MyExampleTest
//
//  Created by chen on 13-8-28.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import "BaiDuMapViewController.h"

#import "BMKMapView.h"

@interface BaiDuMapViewController ()<BMKMapViewDelegate>
{
    BMKMapView* _mapView;
}

@end

@implementation BaiDuMapViewController

- (void)dealloc
{
    //测试
    [_mapView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    self.view = _mapView;
//    [_mapView setShowsUserLocation:YES];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation;
{
//    [_mapView setShowsUserLocation:NO];
}

- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
    [mapView setCenterCoordinate:mapView.userLocation.coordinate animated:YES];
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
