//
//  KBMonster.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBMonster.h"
#import "KBGameMovement.h"

@implementation KBMonster

@synthesize sprite;
@synthesize speed;
@synthesize movement;

+(KBMonster *) create {
    KBMonster * monster = [[KBMonster alloc] init];
    
    [monster setSprite: [CCSprite spriteWithFile:@"monster.png"]];
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
