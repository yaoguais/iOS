//
//  demo2Tests.m
//  demo2Tests
//
//  Created by 刘勇 on 16/7/10.
//  Copyright (c) 2016 刘勇. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface demo2Tests : XCTestCase

@end

@implementation demo2Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
