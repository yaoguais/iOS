//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnExample.h"
#import "JegarnClient.h"
#import "JegarnListener.h"
#import "JegarnPacketWriter.h"
#import "JegarnListenerExample.h"


@implementation JegarnExample

- (void) connectToServer
{
    _client = [[JegarnClient alloc] init];
    _client.account = @"test";
    _client.password = @"test";
    _client.host = @"jegarn.com";
    _client.port = 7773;
    _client.reconnectInterval = 30.0;
    _client.listener = [[JegarnListenerExample alloc] init];
    _client.runLoop = [NSRunLoop currentRunLoop];
    _client.runLoopMode = NSDefaultRunLoopMode;
    [_client connect];
    NSTimer *sendMsgTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(sslTransportSendMessageHandler) userInfo:nil repeats:YES];
    [sendMsgTimer setFireDate:[NSDate distantPast]];
}

- (void)sslTransportSendMessageHandler {
    //BOOL sendRet = [_client.packetWriter send:[@"hello world" dataUsingEncoding:NSUTF8StringEncoding]];
    //NSLog(@"send ret %d", sendRet);
}

- (void) disconnectToServer
{
    if(_client){
        [_client disconnect];
    }
}

@end