//
// Created by Yao Guai on 16/10/2.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JegarnChatPacketListenerDelegate;
@protocol JegarnGroupCHatPacketListenerDelegate;
@protocol JegarnChatRoomPacketListenerDelegate;
@protocol JegarnNotificationPacketListenerDelegate;
@class JegarnPacket;


@interface JegarnPacketManager : NSObject{
@public
    NSMutableArray *_delegates;
}
@property (nonatomic, strong, readonly) NSMutableArray *delegates;
+ (instancetype)sharedInstance;
- (BOOL)addDelegate:(id)delegate;
- (BOOL)removeDelegate:(id)delegate;
@end

@interface JegarnChatPacketManager : JegarnPacketManager
@property (nonatomic, strong, readwrite) NSMutableArray <JegarnChatPacketListenerDelegate> *delegates;
+ (instancetype)sharedInstance;
@end

@interface JegarnGroupChatPacketManager : JegarnPacketManager
@property (nonatomic, strong, readwrite) NSMutableArray <JegarnGroupCHatPacketListenerDelegate> *delegates;
+ (instancetype)sharedInstance;
@end

@interface JegarnChatRoomPacketManager : JegarnPacketManager
@property (nonatomic, strong, readwrite) NSMutableArray <JegarnChatRoomPacketListenerDelegate> *delegates;
+ (instancetype)sharedInstance;
@end

@interface JegarnNotificationPacketManager : JegarnPacketManager
@property (nonatomic, strong, readwrite) NSMutableArray <JegarnNotificationPacketListenerDelegate> *delegates;
+ (instancetype)sharedInstance;
@end