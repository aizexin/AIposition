//
//  ViewController.h
//  AIposition
//
//  Created by 艾泽鑫 on 15/9/7.
//  Copyright (c) 2015年 艾泽鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI/BMKLocationService.h>
@interface ViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>

@property(nonatomic,strong)BMKLocationService* locService;
/**
 *  地图View
 */
@property (strong, nonatomic)IBOutlet BMKMapView *mapView;
/**
 *  开始定位按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *startLocationBtn;
/**
 *  停止定位按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *stopLocationBtn;
/**
 *  大头针
 */
@property(nonatomic,strong)BMKPointAnnotation* pointAnnotation;

@end

