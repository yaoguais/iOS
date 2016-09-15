//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGHttpsSessionManager.h"
#import "AFHTTPSessionManager.h"
#import "YGWeakifyStrongifyMicro.h"


@implementation YGHttpsSessionManager

- (YGHttpsSessionManager *)initWithCertFilePath:(NSString *)certFilePath andP12FilePath:(NSString *)p12FilePath andP12Password:(NSString *)p12Password {
    if ((self = [super init]) && (self = [self init])) {
        _certFilePath = certFilePath;
        _p12FilePath = p12FilePath;
        [self initManagerWithCertFilePath:certFilePath andP12FilePath:p12FilePath andP12Password:p12Password];
    }

    return self;
}

- (void)initManagerWithCertFilePath:(NSString *)certFilePath andP12FilePath:(NSString *)p12FilePath andP12Password:(NSString *)p12Password {
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    NSSet *certSet = [NSSet setWithObject:certData];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    policy.allowInvalidCertificates = NO;
    policy.validatesDomainName = YES;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy = policy;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession *_Nonnull session, NSError *_Nonnull error) {
        NSLog(@"setSessionDidBecomeInvalidBlock %@", error);
    }];

    _manager = manager;

    @weakify(self);
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing *_credential) {
        @strongify(self);
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential = nil;
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            NSMutableArray *pinnedCertificates = [NSMutableArray array];
            for (NSData *certificateData in self.manager.securityPolicy.pinnedCertificates) {
                [pinnedCertificates addObject:(__bridge_transfer id) SecCertificateCreateWithData(NULL, (__bridge CFDataRef) certificateData)];
            }
            SecTrustSetAnchorCertificates(challenge.protectionSpace.serverTrust, (__bridge CFArrayRef) pinnedCertificates);

            if ([self.manager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if (credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSFileManager *fileManager = [NSFileManager defaultManager];

            if (![fileManager fileExistsAtPath:p12FilePath]) {
                NSLog(@"client.p12:not exist");
            }
            else {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12FilePath];

                if ([[self class] extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data withPassword:p12Password]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void *certs[] = {certificate};
                    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
                    credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray *) certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data withPassword:(NSString *)p12password {
    NSDictionary *optionsDictionary = @{(__bridge id) kSecImportExportPassphrase : p12password};

    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) inPKCS12Data, (__bridge CFDictionaryRef) optionsDictionary, &items);

    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef) tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef) tempTrust;
    } else {
        NSLog(@"Failed with error code %d", (int) securityError);
        return NO;
    }
    return YES;
}

@end