//
// Created by Yao Guai on 16/9/11.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGEnvironment.h"
#import "UIDevice+HardWare.h"
#import "YGCommonMicro.h"


@implementation YGEnvironment

YGSingletonM(YGEnvironment);

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLocale *locale = [NSLocale currentLocale];

        _nbid = @"";
        _osName = [[UIDevice currentDevice].systemName copy];
        _osVersion = [[UIDevice currentDevice].systemVersion copy];
        _deviceModel = [[UIDevice hardWareModel] copy];
        _appVersion = @"";
        _appBundleId = [[[NSBundle mainBundle] bundleIdentifier] copy];
        _appChannel = @"";
        _appStoreId = @"";
        _screenSize = [NSString stringWithFormat:@"%.0fx%.0f", YGScreenWidth * YGScreenScale, YGScreenHeight * YGScreenScale];
        _languageCode = @"";
        _countryCode = [[locale objectForKey:NSLocaleCountryCode] copy];
    }

    return self;
}


@end