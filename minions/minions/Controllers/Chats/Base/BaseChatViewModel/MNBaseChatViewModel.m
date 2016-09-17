//
// Created by Yao Guai on 16/9/16.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import "MNBaseChatViewModel.h"
#import "NSObject+YYModel.h"
#import "YYModel-prefix.pch"
#import "MNChatMessageModel.h"

@implementation MNBaseChatViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _messages = [[NSMutableArray alloc] init];
    }

    return self;
}

- (NSUInteger) count
{
    return [_messages count];
}

- (MNChatMessageModel *) chatMessageForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _messages[indexPath.row];
}

- (NSIndexPath *) appendChatMessageModel: (MNChatMessageModel *) chatMessageModel
{
    [_messages addObject:chatMessageModel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_messages count] - 1 inSection:0];
    return indexPath;
}

- (void) requestForMessages
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"json"];
    NSString * jsonData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    _messages = [[NSArray yy_modelArrayWithClass:[MNChatMessageModel class] json:jsonData] mutableCopy];
}

@end