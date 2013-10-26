//
//  KBPlayer.m
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBPlayer.h"

@implementation KBPlayer

@synthesize sprite;
@synthesize speed;
@synthesize movement;

+(KBPlayer *) create {
    KBPlayer * player = [[KBPlayer alloc] init];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCSprite *sprite = [CCSprite spriteWithFile:@"player.png"];
    sprite.position = ccp(sprite.contentSize.width/2, winSize.height/2);
    
    [player setSprite:sprite];
    
    return player;
}

@end
