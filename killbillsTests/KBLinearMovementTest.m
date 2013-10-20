//
//  KBLinearMovementTest.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "KBGameMovement.h"
#import "OCMock.h"
#import "cocos2d.h"

@interface KBLinearMovementTest : XCTestCase

@end

@implementation KBLinearMovementTest

id<KBGameMovement> movement;

- (void)setUp
{
    movement = [KBLinearMovement alloc];
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSendsActions
{
    id mockSprite = [OCMockObject mockForClass:[CCSprite class]];
    id mockGameObject = [OCMockObject mockForProtocol:@protocol(KBMovingObject)];
   
    [[[mockSprite stub] andReturn:nil] runAction:[OCMArg any]];
    [[[mockGameObject stub] andReturn:mockSprite] sprite];
    
    [movement move: mockGameObject];
    
    [mockSprite verify];
    [mockGameObject verify];
}

@end
