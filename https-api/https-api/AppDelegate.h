//
//  AppDelegate.h
//  https-api
//
//  Created by 刘勇 on 16/8/14.
//  Copyright (c) 2016 刘勇. All rights reserved.
//


#import <UIKit/UIKit.h>

@class AFHTTPSessionManager;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AFHTTPSessionManager * manager;


@end
