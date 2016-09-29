//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    JegarnDecoderEventProtocolError,
    JegarnDecoderEventConnectionClosed,
    JegarnDecoderEventConnectionError
} JegarnDecoderEvent;

typedef enum {
    JegarnDecoderStateInitializing,
    JegarnDecoderStateDecodingHeader,
    JegarnDecoderStateDecodingLength,
    JegarnDecoderStateDecodingData,
    JegarnDecoderStateConnectionClosed,
    JegarnDecoderStateConnectionError,
    JegarnDecoderStateProtocolError
} JegarnDecoderState;

@class JegarnDecoder;

@protocol JegarnDecoderDelegate <NSObject>

- (void)decoder:(JegarnDecoder *)sender didReceiveMessage:(NSData *)data;
- (void)decoder:(JegarnDecoder *)sender handleEvent:(JegarnDecoderEvent)eventCode error:(NSError *)error;

@end


@interface JegarnDecoder : NSObject <NSStreamDelegate>
@property (nonatomic)    JegarnDecoderState       state;
@property (strong, nonatomic)    NSRunLoop*      runLoop;
@property (strong, nonatomic)    NSString*       runLoopMode;
@property (nonatomic)    UInt32          length;
@property (nonatomic)    UInt32          lengthMultiplier;
@property (nonatomic)    int          offset;
@property (strong, nonatomic)    NSMutableData*  dataBuffer;

@property (weak, nonatomic ) id<JegarnDecoderDelegate> delegate;

- (void)open;
- (void)close;
- (void)decodeMessage:(NSData *)data;
@end