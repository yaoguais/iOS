//
// Created by 刘勇 on 16/8/21.
// Copyright (c) 2016 tableview.jegarn.com. All rights reserved.
//

#import "Feed.h"


@implementation Feed

#pragma mark 根据字典初始化微博对象
-(Feed *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        self.Id=[dic[@"Id"] longLongValue];
        self.profileImageUrl=dic[@"profileImageUrl"];
        self.userName=dic[@"userName"];
        self.mbtype=dic[@"mbtype"];
        self.createdAt=dic[@"createdAt"];
        self.source=dic[@"source"];
        self.text=dic[@"text"];
    }
    return self;
}

#pragma mark 初始化微博对象（静态方法）
+(Feed *)statusWithDictionary:(NSDictionary *)dic{
    Feed *status=[[Feed alloc]initWithDictionary:dic];
    return status;
}

-(NSString *)source{
    return [NSString stringWithFormat:@"来自 %@",_source];
}

@end