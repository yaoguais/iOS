//
//  AppDelegate.m
//  minions
//
//  Created by Yao Guai on 16/9/10.
//  Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//


#import <AFNetworking/AFHTTPSessionManager.h>
#import "AppDelegate.h"
#import "MNLoginViewController.h"
#import "MNMainTabBarViewController.h"
#import "MNHttpsSessionManager.h"
#import "YGHttpManager.h"
#import "JegarnClient.h"
#import "JegarnSecurityPolicy.h"
#import "MNChatListener.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window.backgroundColor = [UIColor whiteColor];
    [self presentLoginViewController];
    [self initHttpManager];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initHttpManager {
    YGHttpsSessionManager *manager = [[MNHttpsSessionManager alloc] init];
    [YGHttpManager setDefaultManager:manager];
}

- (void)presentMainTabBarViewController {
    MNMainTabBarViewController *tabBarViewController = [[MNMainTabBarViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarViewController];
    _window.rootViewController = navigationController;
}

- (void)presentLoginViewController {
    MNLoginViewController *loginViewController = [[MNLoginViewController alloc] init];
    _window.rootViewController = loginViewController;
}

- (void)startChatClientAccount:(NSString *)account password:(NSString *)password{
    if(!_chatClient){
        _chatClient = [[JegarnClient alloc] init];
        _chatClient.account = account;
        _chatClient.password = password;
        _chatClient.host = @"jegarn.com";
        _chatClient.port = 9501;
        _chatClient.reconnectInterval = 60.0;
        _chatClient.listener = [[MNChatListener alloc] init];
        _chatClient.runLoop = [NSRunLoop currentRunLoop];
        _chatClient.runLoopMode = NSDefaultRunLoopMode;
        _chatClient.enableSsl = true;
        _chatClient.securityPolicy = [JegarnSecurityPolicy defaultPolicy];
        _chatClient.certificates = nil;
        [_chatClient connect];
    }
}

@end