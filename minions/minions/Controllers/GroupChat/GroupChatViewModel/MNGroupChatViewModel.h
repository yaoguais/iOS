//
// Created by Yao Guai on 16/9/18.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MNGroupModel;


@interface MNGroupChatViewModel : NSObject

@property (nonatomic) NSInteger code;
@property (nonatomic, strong) NSArray *groups;

- (NSUInteger)count;
- (MNGroupModel *)groupForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)requestGroupsWithCallback:(void (^)(MNGroupChatViewModel *))callback;


@end