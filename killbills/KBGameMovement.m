//
//  KBLinearMovement.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBGameMovement.h"
#import "cocos2d.h"

@implementation KBLinearMovement

@synthesize object;

- (void) run: (void (^) (CCNode *)) block {

    CCMoveTo * actionMove = [CCMoveTo actionWithDuration: 640 / object.speed
                                                position: ccp(-object.size.width/2, object.position.y)];
    if (block != nil) {
       [object.sprite runAction:[CCSequence actions:actionMove,[CCCallBlockN actionWithBlock:block], nil]];
    } else {
       [object.sprite runAction:[CCSequence actions:actionMove, nil]];
    }
    return;
}

+ (KBLinearMovement *) allocWithMovingObject:(id<KBMovingObject>)inst {
    KBLinearMovement * mov = [[KBLinearMovement alloc] init];
    mov.object = inst;
    return mov;
}

@end


@implementation KBTouchMovement

@synthesize object;
@synthesize touchOffset;

- (void) run: (void (^) (CCNode *)) block {

    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int realX = winSize.width + (object.size.width/2);
    float ratio = (float) self.touchOffset.y / (float) self.touchOffset.x;
    int realY = (realX * ratio) + object.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - object.position.x;
    int offRealY = realY - object.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    if (block != nil) {
        [[object sprite] runAction:
            [CCSequence actions:
                [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                [CCCallBlockN actionWithBlock: block],
                nil]];
    } else {
        [[object sprite] runAction:
            [CCSequence actions:
                [CCMoveTo actionWithDuration:realMoveDuration position:realDest], nil]];
    }
    return;
}


+ (KBTouchMovement *) allocWithMovingObject: (id<KBMovingObject>) object andTouchOffset: (CGPoint) touchLocation {
    KBTouchMovement * mov = [KBTouchMovement alloc];
    [mov setObject:object];
    [mov setTouchOffset:touchLocation];
    return mov;
}

@end