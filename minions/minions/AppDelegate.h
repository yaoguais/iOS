//
//  AppDelegate.h
//  minions
//
//  Created by Yao Guai on 16/9/10.
//  Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@class JegarnCFSocketTransport;
@class YGNSStreamTest;
@class JegarnCFSslSocketTransport;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) YGNSStreamTest * streamTest;
@property (strong, nonatomic) JegarnCFSocketTransport * transport;
@property (strong, nonatomic) JegarnCFSslSocketTransport * sslTransport;
@property (strong, nonatomic) UIWindow *window;

- (void) presentMainTabBarViewController;
- (void) presentLoginViewController;

@end
