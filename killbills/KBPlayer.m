//
//  KBPlayer.m
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBPlayer.h"
#import "KBGameMovement.h"
#import "KBAnimatedSprite.h"

@implementation KBPlayer {
    __strong KBAnimatedSprite * animatedSprite;
}

@synthesize sprite;
@synthesize speed;
@synthesize movement;

+(KBPlayer *) create {
    KBPlayer * player = [[KBPlayer alloc] init];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"jobs.plist"];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    player->animatedSprite = [KBAnimatedSprite createWithBatch:@"jobs.png"
                                                       withMask:@"jobs%d.png"
                                                     andAmount:3];
    
    [player setSprite: [player->animatedSprite spriteSheet]];
   
    [[player sprite]
     setPosition:ccp(20, winSize.height/2)];
   
    [player->animatedSprite setUpdateSpeed:100];
    
    return player;
}


- (CCSprite *) actualSprite {
    return [self->animatedSprite sprite];
}

- (void) prepareProjectile {
    [self->animatedSprite setOnlyFrameNumber:5];
}


- (void) launchProjectile {
    [self->animatedSprite setOnlyFrameNumber:4];
}

- (void) reanimate {
    [[self->animatedSprite sprite] setOpacity: 255];
    [self->animatedSprite reanimate];
}
@end
