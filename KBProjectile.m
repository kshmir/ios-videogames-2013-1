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
   
    CCSprite * sprite =[CCSprite spriteWithFile:@"spinner.png"];
    
    [projectile setSprite: sprite];
    [projectile setMovement: [KBLinearMovement allocWithMovingObject: projectile]];
    [[projectile sprite] setPosition: ccp(20, winSize.height/2)];
    
    [KBAnimate repeatRotate:projectile withAngle:360 andDuration:0.33];
    
    return projectile;
}

-(CGPoint) position {
    return self.sprite.position;
}

-(CGSize) size {
    return self.sprite.contentSize;
}


-(void) move:(void (^)(CCNode *))block {
    [self.movement run: block];
}



@end
