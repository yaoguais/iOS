//
// Created by Yao Guai on 16/9/28.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#ifndef JegarnLog_h
#define JegarnLog_h

    #ifdef LUMBERJACK
        #define LOG_LEVEL_DEF ddLogLevel
            #import <CocoaLumberjack/CocoaLumberjack.h>
            #ifndef myLogLevel
                #ifdef DEBUG
                    static const DDLogLevel ddLogLevel = DDLogLevelWarning;
                #else
                    static const DDLogLevel ddLogLevel = DDLogLevelWarning;
                #endif
            #else
                static const DDLogLevel ddLogLevel = myLogLevel;
            #endif
        #else
        #ifdef DEBUG
            #define DDLogVerbose NSLog
            #define DDLogWarn NSLog
            #define DDLogInfo NSLog
            #define DDLogError NSLog
        #else
            #define DDLogVerbose(...)
            #define DDLogWarn(...)
            #define DDLogInfo(...)
            #define DDLogError(...)
        #endif
    #endif
#endif