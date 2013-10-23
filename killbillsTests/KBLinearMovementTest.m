//
//  KBLinearMovementTest.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "SpecHelper.m"
#import "KBGameMovement.h"

SpecBegin(KBLinearMovement)

describe(@"KBLinearMovement", ^{
    __block id mockSprite;
    __block id mockGameObject;
    
    __block CGPoint position;
    __block CGSize  size;
    
    beforeEach(^{
        mockSprite  = [OCMockObject mockForClass:[CCSprite class]];
        mockGameObject = [OCMockObject mockForProtocol:@protocol(KBMovingObject)];
        position = ccp(10,10);
        
        [[[mockSprite stub] andReturn:nil] runAction:[OCMArg any]];
        [[[mockGameObject stub] andReturn:mockSprite] sprite];
        [[[mockGameObject stub] andReturnValue:OCMOCK_VALUE(size)] size];
        [[[mockGameObject stub] andReturnValue:@1.0] speed];
        [[[mockGameObject stub] andReturnValue:OCMOCK_VALUE(position)] position];
    });
    
    it(@"can call the run method with no block", ^{
        KBLinearMovement * movement = [KBLinearMovement allocWithMovingObject:mockGameObject];
        
        [movement run: nil];
        
        [mockSprite verify];
        [mockGameObject verify];
    });
});

SpecEnd
