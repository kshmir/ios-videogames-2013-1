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
    NSString * mask;
}

@synthesize spriteSheet;
@synthesize sprite;
@synthesize animFrames;


+(KBAnimatedSprite *) createWithBatch: (NSString *) batchSpriteName
                             withMask: (NSString *) spriteNameMask
                            andAmount: (int) amount {
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:batchSpriteName];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=amount; i++) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:spriteNameMask,i]]];
    }
    
    CCSprite * baseSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:spriteNameMask,1]];
    
    [spriteSheet addChild:baseSprite];
    
    KBAnimatedSprite * sprite = [[KBAnimatedSprite alloc]init];
    
    sprite->mask = spriteNameMask;
    [sprite setSprite:baseSprite];
    [sprite setSpriteSheet:spriteSheet];
    [sprite setAnimFrames:walkAnimFrames];
    
    return sprite;
}

-(void) setUpdateSpeed: (double) speed {
    self->_speed = speed;
    [self reanimate];
}

-(void) setOnlyFrameNumber: (int) frame {
    CCSpriteFrame * frameObject = [[CCSpriteFrameCache sharedSpriteFrameCache]
                                   spriteFrameByName: [NSString stringWithFormat:self->mask,frame]];
    
    CCAction * walkAction = [CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:
                           [CCAnimation animationWithSpriteFrames:@[frameObject]
                                                            delay:100000]]];
    [walkAction setTag:10];
    [[self sprite] stopActionByTag:10];
    [[self sprite] runAction:walkAction];
}

-(void) reanimate {
    double actualSpeed = 20.0 / self->_speed;
    CCAction * walkAction = [CCRepeatForever actionWithAction:
                          [CCAnimate actionWithAnimation:
                           [CCAnimation animationWithSpriteFrames:[self animFrames]
                                                            delay:actualSpeed]]];
    [walkAction setTag:10];
    [[self sprite] stopActionByTag:10];
    [[self sprite] runAction: walkAction];
}

@end
