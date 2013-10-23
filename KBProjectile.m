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
    
    [projectile setSprite: [CCSprite spriteWithFile:@"monster.png"]];
    [projectile setMovement: [KBLinearMovement allocWithMovingObject: projectile]];
    
    return projectile;
}

-(CGPoint) position {
    return self.sprite.position;
}

-(CGSize) size {
    return self.sprite.contentSize;
}




-(void) move:(void (^)(CCNode *))block {
    
}



@end
