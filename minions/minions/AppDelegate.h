//
//  AppDelegate.h
//  minions
//
//  Created by Yao Guai on 16/9/10.
//  Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//


#import <UIKit/UIKit.h>

@class JegarnExample;
@class JegarnClient;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) JegarnClient *chatClient;
@property (strong, nonatomic) UIWindow *window;

- (void) presentMainTabBarViewController;
- (void) presentLoginViewController;
- (void)startChatClientAccount:(NSString *)account password:(NSString *)password;

@end
