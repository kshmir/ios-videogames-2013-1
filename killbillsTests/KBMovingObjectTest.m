//
//  KBMonsterTest.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KBMonster.h"

@interface KBMovingObjectTest : XCTestCase

@end

@implementation KBMovingObjectTest

id<KBMovingObject> object;

- (void)setUp
{
    object = [KBMonster create];
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreatesValidMonster
{
    XCTAssertNotNil(object);
}

- (void)testCreateSetsSprite
{
    XCTAssertNotNil([object sprite]);
}
- (void)testCreateSetsMovement
{
    XCTAssertNotNil([object movement]);
}
- (void)testCreateSetsHeight
{
    XCTAssertTrue([object sprite].contentSize.height == [object size].height);
}
- (void)testCreateSetsWidth
{
    XCTAssertTrue([object sprite].contentSize.width == [object size].width);
}

-(void) testSetsPosition {
    
    XCTAssertTrue(object.position.x != 0);
    XCTAssertTrue(object.position.y != 0);
}

-(void) testSetspeed {
    [object setSpeedBetween:0.1 andBetween:0.2];
    XCTAssertTrue(object.speed >= 0.1);
    XCTAssertTrue(object.speed <= 0.2);
}

@end
