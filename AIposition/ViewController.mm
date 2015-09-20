//
//  ViewController.m
//  AIposition
//
//  Created by 艾泽鑫 on 15/9/7.
//  Copyright (c) 2015年 艾泽鑫. All rights reserved.
//AK   SZbQTiEYoNTiQidX1EIij8o3

#import "ViewController.h"
#import "AIDefine.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locService = [[BMKLocationService alloc]init];
    //添加地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0,Mainsize.width , Mainsize.height - 150)];
    [self.view addSubview:_mapView];
}


//普通态
-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层

}
//罗盘态
-(IBAction)startFollowHeading:(id)sender
{
    NSLog(@"进入罗盘态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
-(IBAction)startFollowing:(id)sender
{
    NSLog(@"进入跟随态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
//停止定位
-(IBAction)stopLocation:(id)sender
{
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;

}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
  
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

#pragma mark -标注(大头针)
//添加标注
- (void)addPointAnnotationWithCLLocation:(CLLocationCoordinate2D)location;
{
  
    _pointAnnotation = [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor = location;
//    coor.latitude = 39.915;
//    coor.longitude = 116.404;
    _pointAnnotation.coordinate = location;
    _pointAnnotation.title = @"test";
    _pointAnnotation.subtitle = @"此Annotation可拖拽!";
 
    [_mapView addAnnotation:_pointAnnotation];
}
#pragma mark -定位
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    [_mapView updateLocationData:userLocation];

//    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    AILog(@"latitude = %f,longitude = %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [self addPointAnnotationWithCLLocation:userLocation.location.coordinate];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}



@end







