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
- (void)dealloc
{
    [sprite dealloc];
    [super dealloc];
}
-(id) init {
  return self;
}
@end
