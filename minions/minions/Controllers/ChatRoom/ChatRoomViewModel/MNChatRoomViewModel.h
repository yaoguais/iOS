//
// Created by Yao Guai on 16/9/17.
// Copyright (c) 2016 minions.jegarn.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MNGroupModel;


@interface MNChatRoomViewModel : NSObject

@property (nonatomic) NSInteger code;
@property (nonatomic, strong) NSArray *groups;

- (NSUInteger)count;
- (MNGroupModel *)groupForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)requestGroupsWithCallback:(void (^)(MNChatRoomViewModel *))callback;

@end