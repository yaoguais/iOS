//
// Created by Yao Guai on 16/9/11.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "UIDevice+HardWare.h"
#import <sys/sysctl.h>

@implementation UIDevice (HardWare)

+ (NSString *)hardWareModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *hwString = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return hwString;
}

@end