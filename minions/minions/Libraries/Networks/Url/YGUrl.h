//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YGUrl : NSObject

+ (NSString *)encodeURL:(NSString *)url;
+ (NSString *)appendQueries:(NSMutableDictionary *)queryParams toUrl:(NSString *)url;

@end