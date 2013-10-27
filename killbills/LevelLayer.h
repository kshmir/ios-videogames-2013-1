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

// HelloWorldLayer
@interface LevelLayer : CCLayerColor

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(KBMenu *) menu;
@end
