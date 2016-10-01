//
// Created by Yao Guai on 16/10/1.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnTest.h"
#import "JegarnCFSocketTransport.h"
#import "JegarnCFSslSocketTransport.h"
#import "JegarnSecurityPolicy.h"
#import "JegarnSslConvert.h"


@implementation JegarnTest

- (void)testJegarn {
    NSThread *myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(testJegarnCore)
                                                   object:nil];
    [myThread start];
}

- (void)testJegarnCore {
    _transport = [[JegarnCFSocketTransport alloc] init];
    _transport.host = @"127.0.0.1";
    _transport.port = 8883;
    [_transport open];
    //[_transport close];
};

- (void)testSslJegarnCore {
    JegarnSecurityPolicy *securityPolicy = [JegarnSecurityPolicy policyWithPinningMode:JegarnSSLPinningModeCertificate];
    NSString *certificate = [[NSBundle bundleForClass:[self class]] pathForResource:@"server" ofType:@"cer"];
    securityPolicy.pinnedCertificates = @[[NSData dataWithContentsOfFile:certificate]];
    securityPolicy.allowInvalidCertificates = NO;
    securityPolicy.validatesCertificateChain = NO;

    NSString *p12File = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSString *p12Password = @"111111";
    NSArray *certificates = [JegarnSslConvert clientCertsFromP12:p12File passphrase:p12Password];

    _sslTransport = [[JegarnCFSslSocketTransport alloc] init];
    //_sslTransport.securityPolicy = securityPolicy;
    //_sslTransport.certificates = certificates;
    _sslTransport.securityPolicy = securityPolicy;
    _sslTransport.certificates = certificates;
    _sslTransport.tls = true;
    _sslTransport.host = @"jegarn.com";
    //_sslTransport.host = @"123.56.79.160";
    _sslTransport.port = 7773;
    [_sslTransport open];
    NSTimer *sendMsgTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(sslTransportSendMessageHandler) userInfo:nil repeats:YES];
    [sendMsgTimer setFireDate:[NSDate distantPast]];
}

- (void)sslTransportSendMessageHandler {
    [_sslTransport send:[@"hello world" dataUsingEncoding:NSUTF8StringEncoding]];
}


@end