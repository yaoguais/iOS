//
//  AppDelegate.h
//  minions
//
//  Created by Yao Guai on 16/9/10.
//  Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@class JegarnCFSocketTransport;
@class JegarnCFSslSocketTransport;
@class JegarnExample;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) JegarnExample *jegarnExample;
@property (strong, nonatomic) UIWindow *window;

- (void) presentMainTabBarViewController;
- (void) presentLoginViewController;

@end
