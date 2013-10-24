//
//  KBProjectile.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBProjectile.h"

@implementation KBProjectile

@synthesize sprite;
@synthesize speed;
@synthesize movement;


+(KBProjectile *) create {
    KBProjectile * projectile = [[KBProjectile alloc] init];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    [projectile setSprite: [CCSprite spriteWithFile:@"projectile.png"]];
    [projectile setMovement: [KBLinearMovement allocWithMovingObject: projectile]];
    [[projectile sprite] setPosition: ccp(20, winSize.height/2)];
    
    return projectile;
}

-(CGPoint) position {
    return self.sprite.position;
}

-(CGSize) size {
    return self.sprite.contentSize;
}


-(void) move:(void (^)(id<KBGameObject>))block {
    [self.movement run: block];
}



@end
