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
    
    CGPoint position = ccp(10,10);
    CGSize  size;
   
    [[[mockSprite stub] andReturn:nil] runAction:[OCMArg any]];
    [[[mockGameObject stub] andReturn:mockSprite] sprite];
    [[[mockGameObject stub] andReturnValue:OCMOCK_VALUE(size)] size];
    [[[mockGameObject stub] andReturnValue:@1.0] speed];
    [[[mockGameObject stub] andReturnValue:OCMOCK_VALUE(position)] position];
    
    movement = [KBLinearMovement allocWithMovingObject:mockGameObject];
    
    [movement run: nil];
    
    [mockSprite verify];
    [mockGameObject verify];
}

@end
