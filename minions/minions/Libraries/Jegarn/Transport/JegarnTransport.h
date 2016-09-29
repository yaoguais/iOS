//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol JegarnTransportDelegate;
@protocol JegarnTransport <NSObject>
typedef NS_ENUM(NSInteger, JegarnTransportState) {
            JegarnTransportCreated = 0,
            JegarnTransportOpening,
            JegarnTransportOpen,
            JegarnTransportClosing,
            JegarnTransportClosed
};

@property (strong, nonatomic) NSRunLoop * _Nonnull runLoop;
@property (strong, nonatomic) NSString * _Nonnull runLoopMode;
@property (strong, nonatomic) _Nullable id<JegarnTransportDelegate> delegate;
@property (nonatomic) JegarnTransportState state;
- (void)open;
- (BOOL)send:(nonnull NSData *)data;
- (void)close;
@end

@protocol JegarnTransportDelegate <NSObject>
- (void)JegarnTransport:(nonnull id<JegarnTransport>)JegarnTransport didReceiveMessage:(nonnull NSData *)message;
@optional
- (void)JegarnTransportDidOpen:(_Nonnull id<JegarnTransport>)JegarnTransport;
- (void)JegarnTransport:(_Nonnull id<JegarnTransport>)JegarnTransport didFailWithError:(nullable NSError *)error;
- (void)JegarnTransportDidClose:(_Nonnull id<JegarnTransport>)JegarnTransport;
@end

@interface JegarnTransport : NSObject <JegarnTransport>
@end
