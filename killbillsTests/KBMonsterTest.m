//
//  KBMonsterTest.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KBMonster.h"

@interface KBMonsterTest : XCTestCase

@end

@implementation KBMonsterTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    XCTAssertNotNil([KBMonster create]);
}

@end
