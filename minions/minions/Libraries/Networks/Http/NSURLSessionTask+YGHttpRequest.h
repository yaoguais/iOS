//
//  AppDelegate.h
//  minions
//
//  Created by Yao Guai on 16/9/10.
//  Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NSURLSessionTask(YGHttpRequest)
@property (strong, nonatomic) id httpRequestTag;
@end