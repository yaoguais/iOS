//
//  AppDelegate.h
//  minions
//
//  Created by Yao Guai on 16/9/10.
//  Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//


#import <objc/runtime.h>
#import "YGCommonMicro.h"

@implementation NSURLSessionTask(HttpEngineTag)
static void * s_HttpEngine_UserTak_Key;

- (id)httpRequestTag {
    return objc_getAssociatedObject(self, &s_HttpEngine_UserTak_Key);
}

- (void)setHttpRequestTag:(id)httpRequestTag {
    objc_setAssociatedObject(self, &s_HttpEngine_UserTak_Key, httpRequestTag, OBJC_ASSOCIATION_RETAIN);
}

@end