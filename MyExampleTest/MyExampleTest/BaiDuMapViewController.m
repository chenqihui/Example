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
    [_mapView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.view = _mapView;
    [_mapView setShowsUserLocation:YES];
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation;
{
    [mapView setCenterCoordinate:userLocation.coordinate animated:YES];
    [mapView addAnnotation:userLocation];
    [_mapView setShowsUserLocation:NO];
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