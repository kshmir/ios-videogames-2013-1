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
    KBLinearMovement * mov = [KBLinearMovement alloc];
    mov.object = inst;
    return mov;
}

@end
