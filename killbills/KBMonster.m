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
    monster.sprite = @"monster.png";
    return monster;
}

-(id) init {
  return self;
}
@end
