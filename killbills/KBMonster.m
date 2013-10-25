//
//  KBMonster.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBMonster.h"
#import "KBGameMovement.h"

@implementation KBMonster {


__strong NSMutableArray * _walkAnimFrames;
__strong CCSprite * _baseSprite;
    
}

@synthesize sprite;
@synthesize speed;
@synthesize movement;

+(KBMonster *) create {
    KBMonster * monster = [[KBMonster alloc] init];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"enemies.plist"];

    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"enemies.png"];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=4; i++) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"en1f%d.png",i]]];
    }
    
    CCSprite * baseSprite = [CCSprite spriteWithSpriteFrameName:@"en1f1.png"];
    
    monster->_walkAnimFrames = walkAnimFrames;
    monster->_baseSprite     = baseSprite;

    CCAction * walkAction = [CCRepeatForever actionWithAction:
                              [CCAnimate actionWithAnimation:
                               [CCAnimation animationWithSpriteFrames:walkAnimFrames delay:1.0f]]];
    [baseSprite runAction:walkAction];
    
    [spriteSheet addChild:baseSprite];
    [monster setSprite: spriteSheet];
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    [[monster sprite] setPosition:ccp(winSize.width/2, winSize.height/2)];
    
    [monster setMovement: [KBLinearMovement allocWithMovingObject: monster]];
    [monster calculatePosition];
    
    return monster;
}

- (void) calculatePosition {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = self.size.height / 2;
    int maxY = winSize.height - self.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    self.sprite.position = ccp(winSize.width + self.size.width/2, actualY);
}

- (CGPoint) position {
    return self.sprite.position;
}

- (CGSize) size {
    return self.sprite.contentSize;
}

-(void) setSpeedBetween: (double) paramSpeed andBetween: (double) topSpeed {
    self.speed = paramSpeed + (rand() * 1.0 / RAND_MAX) * (topSpeed - paramSpeed);
    
    CCAction * walkAction = [CCRepeatForever actionWithAction:
                             [CCAnimate actionWithAnimation:
                              [CCAnimation animationWithSpriteFrames:self->_walkAnimFrames delay:(1.0f * 20/self.speed)]]];
    [self->_baseSprite stopAllActions];
    [self->_baseSprite runAction:walkAction];
    
}

- (void) move:(void (^) (CCNode *)) block {
    [self.movement run: block];
}

- (void)dealloc
{
    [self.sprite dealloc];
    [super dealloc];
}
-(id) init {
  return self;
}
@end
