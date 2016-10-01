//
// Created by Yao Guai on 16/9/30.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "JegarnSslConvert.h"
#import "JegarnLog.h"


@implementation JegarnSslConvert

+ (NSArray *)clientCertsFromP12:(NSString *)path passphrase:(NSString *)passphrase {
    if (!path) {
        DDLogWarn(@"[JegarnCFSocketTransport] no p12 path given");
        return nil;
    }

    NSData *pkcs12data = [[NSData alloc] initWithContentsOfFile:path];
    if (!pkcs12data) {
        DDLogWarn(@"[JegarnCFSocketTransport] reading p12 failed");
        return nil;
    }

    if (!passphrase) {
        DDLogWarn(@"[JegarnCFSocketTransport] no passphrase given");
        return nil;
    }
    CFArrayRef keyref = NULL;
    OSStatus importStatus = SecPKCS12Import((__bridge CFDataRef)pkcs12data,
            (__bridge CFDictionaryRef)[NSDictionary
                    dictionaryWithObject:passphrase
                                  forKey:(__bridge id)kSecImportExportPassphrase],
            &keyref);
    if (importStatus != noErr) {
        DDLogWarn(@"[JegarnCFSocketTransport] Error while importing pkcs12 [%d]", (int)importStatus);
        return nil;
    }

    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(keyref, 0);
    if (!identityDict) {
        DDLogWarn(@"[JegarnCFSocketTransport] could not CFArrayGetValueAtIndex");
        return nil;
    }

    SecIdentityRef identityRef = (SecIdentityRef)CFDictionaryGetValue(identityDict,
            kSecImportItemIdentity);
    if (!identityRef) {
        DDLogWarn(@"[JegarnCFSocketTransport] could not CFDictionaryGetValue");
        return nil;
    };

    SecCertificateRef cert = NULL;
    OSStatus status = SecIdentityCopyCertificate(identityRef, &cert);
    if (status != noErr) {
        DDLogWarn(@"[JegarnCFSocketTransport] SecIdentityCopyCertificate failed [%d]", (int)status);
        return nil;
    }

    NSArray *clientCerts = [[NSArray alloc] initWithObjects:(__bridge id)identityRef, (__bridge id)cert, nil];
    return clientCerts;
}


@end