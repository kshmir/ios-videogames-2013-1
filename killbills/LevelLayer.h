//
//  HelloWorldLayer.h
//  killbills
//
//  Created by Cristian Pereyra on 12/09/13.
//  Copyright Cristian Pereyra 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "KBMenu.h"
#import "KBAppDelegate.h"
#import "KBMonster.h"
#import "KBGameObject.h"
#import "KBProjectile.h"
#import "KBCollisionDetector.h"
#import "KBPlayer.h"
#import "KBGUI.h"
#import "KBLive.h"

@class KBMenu;
// HelloWorldLayer
@interface LevelLayer : CCLayerColor

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void) increaseLevel;
-(void) removeObject: (id<KBGameObject>) node;

- (void) addChildMonster;
- (void) addChildMonsterBoss;
- (void) animateExplosion:(id)gameObject;
- (KBMenu *) menu;
@end
