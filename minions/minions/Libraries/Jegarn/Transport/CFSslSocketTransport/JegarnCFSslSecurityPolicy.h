//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

typedef NS_ENUM(NSUInteger, JegarnSSLPinningMode) {
    JegarnSSLPinningModeNone,
    JegarnSSLPinningModePublicKey,
    JegarnSSLPinningModeCertificate,
};

@interface JegarnCFSslSecurityPolicy : NSObject
@property (readonly, nonatomic, assign) JegarnSSLPinningMode SSLPinningMode;
@property (nonatomic, assign) BOOL validatesCertificateChain;
@property (nonatomic, strong) NSArray *pinnedCertificates;
@property (nonatomic, assign) BOOL allowInvalidCertificates;
@property (nonatomic, assign) BOOL validatesDomainName;
+ (instancetype)defaultPolicy;
+ (instancetype)policyWithPinningMode:(JegarnSSLPinningMode)pinningMode;
- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(NSString *)domain;
@end