//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnPacketReader.h"
#import "JegarnLog.h"
#import "JegarnClient.h"
#import "JegarnListener.h"
#import "JegarnConvertUtil.h"
#import "MPMessagePackReader.h"
#import "JegarnStringUtil.h"
#import "JegarnAuthPacket.h"
#import "jegarnHasSubTypePacketFactory.h"

@interface JegarnPacketReader ()
@property (strong, nonatomic) NSMutableData *buffer;
@end

@implementation JegarnPacketReader {
@private
    NSInputStream *_stream;
}

@synthesize stream = _stream;

- (instancetype)init {
    self = [super init];
    if (self) {
        _buffer = [[NSMutableData alloc] initWithCapacity:2048];
    }

    return self;
}


- (void)stream:(NSStream *)sender handleEvent:(NSStreamEvent)eventCode {
#ifdef DEBUG
    [self streamHandledEvents:eventCode];
#endif

    if (eventCode & NSStreamEventHasBytesAvailable) {
        if (self.client.enableSsl) {
            if (![self applySSLSecurityPolicy:sender withEvent:eventCode]) {
                DDLogVerbose(@"[JegarnPacketReader] NSStreamEventHasBytesAvailable error %@", sender.streamError);
            } else {
                @synchronized (self) {
                    [self parsePackets:sender];
                }
            }
        } else {
            [self parsePackets:sender];
        }
    }

    if (eventCode & NSStreamEventErrorOccurred || eventCode & NSStreamEventEndEncountered) {
        [self.client.listener errorListener:JegarnErrorTypeNetworkError client:self.client];
        [self.client reconnectDelayInterval];
    }
}

- (void)parsePackets:(NSStream *)sender {
    NSInteger n;
    NSInteger headLen = 4, currentPacketLen = 0;
    NSInteger recvDataLen;
    NSUInteger readStartPos = 0;
    BOOL needRenewRecvData = NO, parsePacketError = NO;

    for (; ;) {
        UInt8 buffer[768];
        n = [(NSInputStream *) sender read:buffer maxLength:sizeof(buffer)];
        DDLogVerbose(@"[JegarnPacketReader] read(%d) %s", n, (char *) buffer);
        if (n < 0) {
            DDLogVerbose(@"[JegarnPacketReader] parsePackets error %@", sender.streamError);
            break;
        }
        if (n == 0) {
            if ([sender streamStatus] == NSStreamStatusClosed) {
                DDLogVerbose(@"[JegarnPacketReader] parsePackets connection lost");
            }
            break;
        }
        [self.buffer appendBytes:buffer length:n];
        if (![(NSInputStream *) sender hasBytesAvailable]) {
            break;
        }
    }

    recvDataLen = [self.buffer length];
    for(;;){
        if (recvDataLen - readStartPos <= headLen) {
            break;
        }
        currentPacketLen = [JegarnConvertUtil binaryStringToInt:[self.buffer subdataWithRange:NSMakeRange(readStartPos, headLen)]];
        if(currentPacketLen <= 0){
            needRenewRecvData = parsePacketError = YES;
            break;
        }
        if (readStartPos + headLen + currentPacketLen <= recvDataLen) {
            if(![self parseOnePacketData:self.buffer offset:readStartPos+headLen length:currentPacketLen]){
                parsePacketError = YES;
            }
            readStartPos += headLen + currentPacketLen;
            needRenewRecvData = YES;
        }else{
            break;
        }
    }
    if (needRenewRecvData) {
        if(readStartPos < recvDataLen){
            NSData * restData = nil;
            if(!parsePacketError){
                restData = [self.buffer subdataWithRange:NSMakeRange(readStartPos, recvDataLen - readStartPos)];
            }
            self.buffer = [[NSMutableData alloc] initWithCapacity:2048];
            if (restData) {
                [self.buffer appendData:restData];
            }
        }else{
            self.buffer.length = 0;
        }
    }
}

- (BOOL) parseOnePacketData:(NSMutableData *)data  offset:(NSUInteger) offset length:(NSUInteger) length
{
    NSData * packetData = [data subdataWithRange:NSMakeRange(offset, length)];
    NSError * error = nil;
    id packetDict = [MPMessagePackReader readData:packetData error:&error];
    NSLog(@"[JegarnPacketReader] parseOnePacketData packetDict %@", packetDict);
    if(error || ![packetDict isKindOfClass:[NSDictionary class]]){
        DDLogVerbose(@"[JegarnPacketReader] parseOnePacketData parse full packet failed");
        [self.client.listener errorListener:JegarnErrorTypeRecvPacketCrashed client:self.client];
        return NO;
    }
    NSString *sessionId = packetDict[JegarnSessionKey];
    NSString *from = [JegarnConvertUtil idToString:packetDict[@"from"]];
    NSString *to = [JegarnConvertUtil idToString:packetDict[@"to"]];
    NSString *type = packetDict[@"type"];
    id content = packetDict[@"content"];
    if([JegarnStringUtil isEmptyString:from] || [JegarnStringUtil isEmptyString:to] || [JegarnStringUtil isEmptyString:type]) {
        DDLogVerbose(@"[JegarnPacketReader] parseOnePacketData packet empty from/to/type");
        [self.client.listener errorListener:JegarnErrorTypeRecvPacketCrashed client:self.client];
        return YES;
    }
    if(!content || ![content isKindOfClass:[NSDictionary class]]){
        DDLogVerbose(@"[JegarnPacketReader] parseOnePacketData packet empty content");
        [self.client.listener errorListener:JegarnErrorTypeRecvPacketCrashed client:self.client];
        return YES;
    }
    if(!self.client.authorized){
        if (![type isEqualToString:[JegarnAuthPacket packetType]]) {
            DDLogVerbose(@"[JegarnPacketReader] parseOnePacketData recv other packet before authorized");
            [self.client.listener errorListener:JegarnErrorTypeRecvPacketCrashed client:self.client];
        }else{
            NSString * uid = content[@"uid"];
            NSInteger status = [(NSNumber *) content[@"status"] integerValue];
            switch (status) {
                case JegarnAuthPacketStatusNeedAuth:
                    [self.client auth];
                    break;
                case JegarnAuthPacketStatusAuthSuccess:
                    self.client.uid = uid;
                    self.client.sessionId = sessionId;
                    self.client.authorized = true;
                    [self.client.listener connectListener:self.client];
                    break;
                case JegarnAuthPacketStatusAuthFailed:
                    DDLogVerbose(@"[JegarnPacketReader] parseOnePacketData auth failed");
                    [self.client.listener errorListener:JegarnErrorTypeAuthFailed client:self.client];
                    break;
                default:
                    DDLogVerbose(@"[JegarnPacketReader] parseOnePacketData recv auth packet status(%d) not defined", status);
                    [self.client.listener errorListener:JegarnErrorTypeRecvPacketCrashed client:self.client];
                    break;
            }
        }
    }else{
        JegarnPacket * packet = [[jegarnHasSubTypePacketFactory sharedInstance] getPacket:from to:to type:type content:content];
        if(packet){
            [self processPacket:packet];
        }else{
            DDLogVerbose(@"[JegarnPacketReader] parseOnePacketData packet not support");
            [self.client.listener errorListener:JegarnErrorTypeRecvPacketType client:self.client];
        }
    }

    return YES;
}

- (void) processPacket:(JegarnPacket *) packet
{
    [self.client.listener packetListener:packet client:self.client];
}

- (void)streamHandledEvents:(NSStreamEvent)eventCode {
    if (eventCode & NSStreamEventNone) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventNone");
    }
    if (eventCode & NSStreamEventOpenCompleted) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventOpenCompleted");
    }
    if (eventCode & NSStreamEventHasBytesAvailable) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventHasBytesAvailable");
    }
    if (eventCode & NSStreamEventHasSpaceAvailable) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventHasSpaceAvailable");
    }
    if (eventCode & NSStreamEventErrorOccurred) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventErrorOccurred");
    }
    if (eventCode & NSStreamEventEndEncountered) {
        DDLogVerbose(@"[JegarnPacketReader] NSStreamEventEndEncountered");
    }
}

@end