//
//  AppDelegate.m
//  mqtt
//
//  Created by 刘勇 on 16/8/26.
//  Copyright (c) 2016 mqtt.jegarn.com. All rights reserved.
//


#import "AppDelegate.h"
#import "MQTTCFSocketTransport.h"
#import "MQTTSessionSynchron.h"
#import "MQTTSSLSecurityPolicy.h"
#import "MQTTSessionLegacy.h"


@interface AppDelegate ()
@property(strong, nonatomic) MQTTSession *session;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpMqtt];

    return YES;
}

- (void)setUpMqtt {

    MQTTSSLSecurityPolicy *securityPolicy = [MQTTSSLSecurityPolicy policyWithPinningMode:MQTTSSLPinningModeCertificate];
    NSString *certificate = [[NSBundle bundleForClass:[self class]] pathForResource:@"server" ofType:@"cer"];
    securityPolicy.pinnedCertificates = @[[NSData dataWithContentsOfFile:certificate]];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesCertificateChain = NO;

    NSString *p12File = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSString *p12Password = @"111111";
    NSArray * certificates = [MQTTCFSocketTransport clientCertsFromP12:p12File passphrase:p12Password];

    _session = [[MQTTSession alloc] init];
    _session.cleanSessionFlag = YES;
    _session.delegate = self;
    _session.userName = @"test";
    _session.password = @"test";
    _session.securityPolicy = securityPolicy;
    _session.certificates = certificates;

    [_session connectToHost:@"jegarn.com" port:8883 usingSSL:YES connectHandler:^(NSError *error) {
        NSLog(@"connect error %@", error);
        // 简单测试订阅/发布
        [self subscribeTest];
        [self publishTest];
    }];
}

- (void)subscribeTest {
    [_session subscribeToTopic:@"world" atLevel:1 subscribeHandler:^(NSError *error, NSArray<NSNumber *> *gQoss) {
        if (error) {
            NSLog(@"Subscription failed %@", error.localizedDescription);
        } else {
            NSLog(@"Subscription successfully! Granted Qos: %@", gQoss);
        }
    }];
};

- (void)publishTest {

    [_session publishAndWaitData:[@"hello" dataUsingEncoding:NSUTF8StringEncoding]
                         onTopic:@"world"
                          retain:NO
                             qos:MQTTQosLevelAtLeastOnce
                         timeout:30];
}

- (void)newMessage:(MQTTSession *)session
              data:(NSData *)data
           onTopic:(NSString *)topic
               qos:(MQTTQosLevel)qos
          retained:(BOOL)retained
               mid:(unsigned int)mid {
    // this is one of the delegate callbacks
    NSLog(@"new message %@ from topic %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding], topic);
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


@end