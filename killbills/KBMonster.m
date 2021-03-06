//
//  KBMonster.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "LevelLayer.h"
#import "KBMonster.h"
#import "KBGameMovement.h"
#import "KBAnimatedSprite.h"

@implementation KBMonster {
    __strong KBAnimatedSprite * animatedSprite;
    LevelLayer * owner;
    int type;
}


@synthesize speed;
@synthesize movement;
@synthesize sprite;
@synthesize liveCount;

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
+(KBMonster *) createSpeeder: (LevelLayer *) owner {
    KBMonster * monster = [KBMonster create];
   
    [KBAnimate repeatTint:[monster->animatedSprite sprite] fromR:255 fromG:255 fromB:255 toR:128 toG:255 toB:128 withDuration:0.25];
    [KBAnimate repeatRotateNode:[monster->animatedSprite sprite] withAngle:360 andDuration:1.25];
    monster->type = KBM_SPEEDER;
    monster->owner = owner;
   
    return monster;
}

+(KBMonster *) createBoss: (LevelLayer *) owner {
    KBMonster * monster = [KBMonster create];
    
    monster->type = KBM_BOSS;
    monster->owner = owner;
    monster.liveCount = 30;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = monster.size.height / 2;
    int maxY = winSize.height - monster.size.height/2;
    monster.sprite.position = ccp(winSize.width + monster.size.width/2, (maxY + minY) / 2);
    [[monster-> animatedSprite sprite] setScale:2.5];
    
    [[monster->animatedSprite sprite] runAction:[CCTintTo actionWithDuration:10 red:128 green:0 blue:0]];
    
    [[owner scheduler] scheduleSelector:@selector(explode)
                              forTarget:monster
                               interval:10
                                 repeat:0
                                  delay:0
                                 paused:NO];
    
    return monster;
}

+(KBMonster *) createBerserk: (LevelLayer *) owner {
    KBMonster * monster = [KBMonster create];
    
    monster->type = KBM_BERSERK;
    monster->owner = owner;
    
    [[monster->animatedSprite sprite] runAction:[CCTintTo actionWithDuration:10 red:128 green:0 blue:0]];

    [[owner scheduler] scheduleSelector:@selector(explode)
                              forTarget:monster
                               interval:10
                                 repeat:0
                                  delay:0
                                 paused:NO];
    
    return monster;
}

- (int) type {
    return self->type;
}

- (void) setLevel: (int) level {
    
}

- (void) explode {
    if ([self sprite] != nil && [[self sprite] tag] != KBO_DEAD) {
        @try {
            [owner animateExplosion:self];
            [owner removeObject: self];
            if (self->type != KBM_BOSS) {
               [owner addChildMonster];
            }
            else {
               [owner addChildMonsterBoss];
            }
        }
        @catch (NSException *exception) {
            [[self sprite] setTag:KBO_DEAD];
        }
        @finally {
            [[self sprite] setTag:KBO_DEAD];
        }
    }
}

- (CCNode *) sprite {
    return [animatedSprite spriteSheet];
}

- (void) setSprite:(CCNode *)sprite {
    // nop
}

- (void) move:(void (^)(CCNode *))block {
    if (type == KBM_BERSERK) {
        self.speed /= 10;
    }
    if (type == KBM_BOSS) {
        self.speed /= 50;
    }
    [super move: block];
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
    if (type == KBM_BERSERK) {
        self.speed *= 2;
    }
    
    [self->animatedSprite setUpdateSpeed:self.speed];
    
    if (type == KBM_SPEEDER) {
        self.speed *= 3;
    }
}

@end
