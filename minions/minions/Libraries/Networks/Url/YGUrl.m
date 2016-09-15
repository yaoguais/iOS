//
// Created by Yao Guai on 16/9/10.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "YGUrl.h"


@implementation YGUrl

+ (NSString *)encodeURL:(NSString *)url {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[url UTF8String];
    unsigned char thisChar;
    int sourceLen = (int) strlen((const char *) source);
    for (int i = 0; i < sourceLen; ++i) {
        thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                (thisChar >= 'a' && thisChar <= 'z') ||
                (thisChar >= 'A' && thisChar <= 'Z') ||
                (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)appendQueries:(NSMutableDictionary *)queryParams toUrl:(NSString *)url {
    if ([queryParams count] == 0) {
        return url;
    }
    __block NSMutableString *finalUrl = [url mutableCopy];
    const unsigned char *source = (const unsigned char *) [url UTF8String];
    int sourceLen = (int) strlen((const char *) source);
    unsigned char thisChar, i = 0;
    BOOL isFindQuestionMark = NO;
    for (i = 0; i < sourceLen; ++i) {
        thisChar = source[i];
        if (thisChar == '?') {
            isFindQuestionMark = YES;
            break;
        }
    }
    if (!isFindQuestionMark) {
        [finalUrl appendString:@"?"];
    }
    __block BOOL addAmpersandMark = isFindQuestionMark && source[sourceLen - 1] != '?' && source[sourceLen - 1] != '&';

    [queryParams enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *valueArray = (NSArray *) obj;
            NSString *paramKey = [NSString stringWithFormat:@"%@[]", key];
            for (id obj in valueArray) {
                [finalUrl appendFormat:@"%@%@=%@", addAmpersandMark ? @"&" : @"", paramKey, [YGUrl encodeURL:obj]];
                addAmpersandMark = YES;
            }
        }
        else {
            [finalUrl appendFormat:@"%@%@=%@", addAmpersandMark ? @"&" : @"", key, [YGUrl encodeURL:obj]];
            addAmpersandMark = YES;
        }
    }];

    return finalUrl;
}

@end