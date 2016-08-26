//
//  AppDelegate.h
//  mqtt
//
//  Created by 刘勇 on 16/8/26.
//  Copyright (c) 2016 mqtt.jegarn.com. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MQTTSession.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, MQTTSessionDelegate>

@property (strong, nonatomic) UIWindow *window;


@end
