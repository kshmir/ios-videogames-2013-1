//
//  KBLive.m
//  killbills
//
//  Created by Cristian Pereyra on 10/28/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBLive.h"

@implementation KBLive

@synthesize speed;
@synthesize movement;
@synthesize sprite;

+(KBLive *) create {
    KBLive * live = [[KBLive alloc] init];
   
    [live setSprite:[CCSprite spriteWithFile:@"live.png"]];
    
    [live setMovement: [KBLinearMovement allocWithMovingObject: live]];
    [live calculatePosition];
    
    return live;
}

-(void) calculatePosition {
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = self.size.height / 2;
    int maxY = winSize.height - self.size.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    self.sprite.position = ccp(winSize.width + self.size.width/2, actualY);
}

@end
