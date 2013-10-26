//
//  KBMonster.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBMonster.h"
#import "KBGameMovement.h"
#import "KBAnimatedSprite.h"

@implementation KBMonster {
    __strong KBAnimatedSprite * animatedSprite;
}

@synthesize speed;
@synthesize movement;
@synthesize sprite;

+(KBMonster *) create {
    KBMonster * monster = [[KBMonster alloc] init];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemies.plist"];
    
    monster->animatedSprite = [KBAnimatedSprite createWithBatch:@"enemies.png"
        withMask:@"en1f%d.png"
        andAmount:4];

    [monster setSprite: [monster->animatedSprite spriteSheet]];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    [[monster sprite] setPosition:ccp(winSize.width/2, winSize.height/2)];
    
    [monster setMovement: [KBLinearMovement allocWithMovingObject: monster]];
    [monster calculatePosition];
    
    return monster;
}

- (CCNode *) sprite {
    return [animatedSprite spriteSheet];
}

- (void) setSprite:(CCNode *)sprite {
    // nop
}

- (void) calculatePosition {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = self.size.height / 2;
    int maxY = winSize.height - self.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    self.sprite.position = ccp(winSize.width + self.size.width/2, actualY);
}

-(void) setSpeedBetween: (double) paramSpeed andBetween: (double) topSpeed {
    self.speed = paramSpeed + (rand() * 1.0 / RAND_MAX) * (topSpeed - paramSpeed);
    [self->animatedSprite setUpdateSpeed:self.speed];
}

@end
