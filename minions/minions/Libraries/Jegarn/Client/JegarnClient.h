//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JegarnPacket.h"

@class JegarnListener;
@class JegarnPacketReader;
@class JegarnPacketWriter;
@class JegarnSecurityPolicy;
@protocol JegarnListenerDelegate;

typedef enum {
    JegarnErrorTypeNetworkError,
    JegarnErrorTypeRecvPacketCrashed,
    JegarnErrorTypeRecvPacketType,
    JegarnErrorTypeAuthFailed,
    JegarnErrorTypeSendPacketValid
} JegarnErrorType;

typedef NS_ENUM(NSInteger, JegarnAuthPacketStatus) {
    JegarnAuthPacketStatusNeedAuth = 1,
    JegarnAuthPacketStatusAuthSuccess = 2,
    JegarnAuthPacketStatusAuthFailed = 3
};

#define JegarnSessionKey @"session_id"

@interface JegarnClient : NSObject

@property (nonatomic, copy) NSString * account;
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * uid;
@property (nonatomic, copy) NSString * host;
@property (nonatomic) UInt16 port;
@property (nonatomic) BOOL running;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic) BOOL authorized;
@property (nonatomic) BOOL enableSsl;
@property (strong, nonatomic) NSArray *certificates;
@property(strong, nonatomic) JegarnSecurityPolicy *securityPolicy;
@property (nonatomic, strong) id <JegarnListenerDelegate> listener;
@property (nonatomic, strong) JegarnPacketReader *packetReader;
@property (nonatomic, strong) JegarnPacketWriter *packetWriter;
@property (strong, nonatomic) NSRunLoop *runLoop;
@property (strong, nonatomic) NSString *runLoopMode;
@property (strong, nonatomic) NSTimer *reconnectTimer;
@property (nonatomic) double reconnectInterval;

- (BOOL) connect;
- (void) disconnect;
- (void) reconnect;
- (void) reconnectDelayInterval;
- (void) auth;
- (BOOL) sendPacket:(JegarnPacket *)packet;

@end