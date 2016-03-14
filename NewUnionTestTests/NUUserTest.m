//
//  NUUserTest.m
//  NewUnionTest
//
//  Created by Than Dang on 3/14/16.
//  Copyright © 2016 ThanDang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NUUser.h"

@interface NUUserTest : XCTestCase

@end

@implementation NUUserTest

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

- (void) testInputUser {
    NUUser *usr = [NUUser new];
    [usr setUserId:@"user1"];
    XCTAssertNotNil(usr.userId, @"user id not null");
}

- (void) testEqualUser {
    NUUser *usr = [NUUser new];
    [usr setUsername:@"name1"];
    XCTAssertEqual(usr.username, @"name1", @"name equal");
}

@end
