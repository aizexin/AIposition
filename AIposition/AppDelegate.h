//
//  AppDelegate.h
//  AIposition
//
//  Created by 艾泽鑫 on 15/9/7.
//  Copyright (c) 2015年 艾泽鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic) BMKMapManager *mapManager;

@end

