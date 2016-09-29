//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JegarnCFSocketDecoderState) {
    JegarnCFSocketDecoderStateInitializing,
    JegarnCFSocketDecoderStateReady,
    JegarnCFSocketDecoderStateError
};

@class JegarnCFSocketDecoder;

@protocol JegarnCFSocketDecoderDelegate <NSObject>
- (void)decoder:(JegarnCFSocketDecoder *)sender didReceiveMessage:(NSData *)data;
- (void)decoderDidOpen:(JegarnCFSocketDecoder *)sender;
- (void)decoder:(JegarnCFSocketDecoder *)sender didFailWithError:(NSError *)error;
- (void)decoderdidClose:(JegarnCFSocketDecoder *)sender;

@end

@interface JegarnCFSocketDecoder : NSObject <NSStreamDelegate>
@property (nonatomic) JegarnCFSocketDecoderState state;
@property (strong, nonatomic) NSError *error;
@property (strong, nonatomic) NSInputStream *stream;
@property (strong, nonatomic) NSRunLoop *runLoop;
@property (strong, nonatomic) NSString *runLoopMode;
@property (weak, nonatomic ) id<JegarnCFSocketDecoderDelegate> delegate;

- (void)open;
- (void)close;

@end


