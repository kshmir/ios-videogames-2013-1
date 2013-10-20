//
//  KBMonster.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBMonster.h"

@implementation KBMonster

@synthesize sprite;
@synthesize speed;

+(KBMonster *) create {
    KBMonster * monster = [KBMonster alloc];
    CCSprite * sprite = [CCSprite spriteWithFile:@"monster.png"];
    monster.sprite = sprite;
    return monster;
}

- (int) height {
    return self.sprite.contentSize.height;
}

- (int) width {
    return self.sprite.contentSize.width;
}

- (void) setPosition: (CGSize) winSize {
    int minY = self.height / 2;
    int maxY = winSize.height - self.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    self.sprite.position = ccp(winSize.width + self.width/2, actualY);
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
