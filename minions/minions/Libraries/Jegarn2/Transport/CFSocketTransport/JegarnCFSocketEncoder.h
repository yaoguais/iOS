//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JegarnCFSocketEncoderState) {
    JegarnCFSocketEncoderStateInitializing,
    JegarnCFSocketEncoderStateReady,
    JegarnCFSocketEncoderStateError
};

@class JegarnCFSocketEncoder;

@protocol JegarnCFSocketEncoderDelegate <NSObject>
- (void)encoderDidOpen:(JegarnCFSocketEncoder *)sender;
- (void)encoder:(JegarnCFSocketEncoder *)sender didFailWithError:(NSError *)error;
- (void)encoderdidClose:(JegarnCFSocketEncoder *)sender;

@end

@interface JegarnCFSocketEncoder : NSObject <NSStreamDelegate>
@property (nonatomic) JegarnCFSocketEncoderState state;
@property (strong, nonatomic) NSError *error;
@property (strong, nonatomic) NSOutputStream *stream;
@property (strong, nonatomic) NSRunLoop *runLoop;
@property (strong, nonatomic) NSString *runLoopMode;
@property (weak, nonatomic ) id<JegarnCFSocketEncoderDelegate> delegate;

- (void)open;
- (void)close;
- (BOOL)send:(NSData *)data;

@end