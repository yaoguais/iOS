//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnExample.h"
#import "JegarnClient.h"
#import "JegarnListener.h"
#import "JegarnPacketWriter.h"


@implementation JegarnExample

- (void) connectToServer
{
    _client = [[JegarnClient alloc] init];
    _client.account = @"";
    _client.password = @"";
    _client.host = @"";
    _client.port = 7773;
    _client.listener = [[JegarnListener alloc] init];
    _client.runLoop = [NSRunLoop currentRunLoop];
    _client.runLoopMode = NSDefaultRunLoopMode;
    [_client connect];
    NSTimer *sendMsgTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(sslTransportSendMessageHandler) userInfo:nil repeats:YES];
    [sendMsgTimer setFireDate:[NSDate distantPast]];
}

- (void)sslTransportSendMessageHandler {
    [_client.packetWriter send:[@"hello world" dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void) disconnectToServer
{
    if(_client){
        [_client disconnect];
    }
}

@end