//
// Created by Yao Guai on 16/9/11.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YGSingletonMicro.h"


@interface YGEnvironment : NSObject

@property (readonly, nonatomic) NSString *nbid;
@property (readonly, nonatomic) NSString *osName;
@property (readonly, nonatomic) NSString *osVersion;
@property (readonly, nonatomic) NSString *deviceModel;
@property (readonly, nonatomic) NSString *appVersion;
@property (readonly, nonatomic) NSString *appBundleId;
@property (readonly, nonatomic) NSString *appChannel;
@property (readonly, nonatomic) NSString *appStoreId;
@property (readonly, nonatomic) NSString *screenSize;
@property (readonly, nonatomic) NSString *languageCode;
@property (readonly, nonatomic) NSString *countryCode;

YGSingletonH(YGEnvironment);

@end