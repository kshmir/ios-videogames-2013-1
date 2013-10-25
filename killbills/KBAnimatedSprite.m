//
//  KBAnimatedSprite.m
//  killbills
//
//  Created by Cristian Pereyra on 10/25/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBAnimatedSprite.h"

@implementation KBAnimatedSprite {
    double _speed;
}

@synthesize spriteSheet;
@synthesize sprite;
@synthesize animFrames;


+(KBAnimatedSprite *) createWithBatch: (NSString *) batchSpriteName
                             withMask: (NSString *) spriteNameMask
                            andAmount: (int) amount {
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:batchSpriteName];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=4; i++) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:spriteNameMask,i]]];
    }
    
    CCSprite * baseSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:spriteNameMask,1]];
    
    [spriteSheet addChild:baseSprite];
    
    KBAnimatedSprite * sprite = [[KBAnimatedSprite alloc]init];
    
    [sprite setSprite:baseSprite];
    [sprite setSpriteSheet:spriteSheet];
    [sprite setAnimFrames:walkAnimFrames];
    
    return sprite;
}

-(void) setUpdateSpeed: (double) speed {
    self->_speed = speed;
    [self reanimate];
}

-(void) reanimate {
    double actualSpeed = 20.0 / self->_speed;
    CCAction * walkAction = [CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:
                           [CCAnimation animationWithSpriteFrames:[self animFrames]
                                                            delay:actualSpeed]]];
    [[self sprite] stopAllActions];
    [[self sprite] runAction:walkAction];
}

@end
