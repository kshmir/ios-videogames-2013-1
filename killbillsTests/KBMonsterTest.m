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

KBMonster * monster;

- (void)setUp
{
    monster = [KBMonster create];
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreatesValidMonster
{
    XCTAssertNotNil(monster);
}

- (void)testCreateSetsSprite
{
    XCTAssertNotNil([monster sprite]);
}
- (void)testCreateSetsMovement
{
    XCTAssertNotNil([monster movement]);
}
- (void)testCreateSetsHeight
{
    XCTAssertTrue([monster sprite].contentSize.height == [monster size].height);
}
- (void)testCreateSetsWidth
{
    XCTAssertTrue([monster sprite].contentSize.width == [monster size].width);
    
}

-(void) testSetsPosition {
    
    XCTAssertTrue(monster.position.x != 0);
    XCTAssertTrue(monster.position.y != 0);
}

-(void) testSetspeed {
    [monster setSpeedBetween:0.1 andBetween:0.2];
    XCTAssertTrue(monster.speed >= 0.1);
    XCTAssertTrue(monster.speed <= 0.2);
}

@end
