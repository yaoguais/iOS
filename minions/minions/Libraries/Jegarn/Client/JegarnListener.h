//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnClient.h"

@class JegarnPacket;
@class JegarnClient;

@protocol JegarnListenerDelegate
- (void) packetListener:(JegarnPacket *)packet client:(JegarnClient *) client;
- (BOOL) sendListener:(JegarnPacket *)packet client:(JegarnClient *) client;
- (void) errorListener:(JegarnErrorType)errorType client:(JegarnClient *) client;
- (void) connectListener:(JegarnClient *) client;
- (void) disconnectListener:(JegarnClient *) client;
@end

@interface JegarnListener : NSObject <JegarnListenerDelegate>

- (void) packetListener:(JegarnPacket *)packet client:(JegarnClient *) client;
- (BOOL) sendListener:(JegarnPacket *)packet client:(JegarnClient *) client;
- (void) errorListener:(JegarnErrorType)errorType client:(JegarnClient *) client;
- (void) connectListener:(JegarnClient *) client;
- (void) disconnectListener:(JegarnClient *) client;

@end