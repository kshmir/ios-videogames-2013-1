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
- (void)testCreateSetsHeight
{
    XCTAssertTrue([monster sprite].contentSize.height == [monster height]);
}
- (void)testCreateSetsWidth
{
    XCTAssertTrue([monster sprite].contentSize.width == [monster width]);
}

-(void) testSetsPosition {
    
    CGSize size;
    size.height = 10;
    size.width = 20;
    [monster setPosition: size];
    XCTAssertTrue(monster.sprite.position.x != 0);
    XCTAssertTrue(monster.sprite.position.y != 0);
}

-(void) testSetspeed {
    XCTAssertNoThrow(monster.speed = 1);
}

@end
