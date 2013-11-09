//
//  KBMonster.h
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KBGameObject.h"
#import "KBGameMovement.h"
#import "KBBaseNode.h"
#import "LevelLayer.h"

#define KBM_NORMAL  0
#define KBM_BERSERK 1
#define KBM_SPEEDER 2
#define KBM_BOSS    3

@class LevelLayer;
@interface KBMonster : KBBaseNode <KBMovingObject>

-(void) setSpeedBetween: (double) speed andBetween: (double) topSpeed;

@property (nonatomic) int liveCount;

- (int) type;
+(KBMonster *) createBoss: (LevelLayer *) owner;
+(KBMonster *) createBerserk: (LevelLayer *) owner;
+(KBMonster *) createSpeeder: (LevelLayer *) owner;
+(KBMonster *) create;

@end
