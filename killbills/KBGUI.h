//
//  KBGUI.h
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "LevelLayer.h"

@class LevelLayer;

@interface KBGUI : NSObject

- (CCNode *) gui;

- (void) resumeClick: (id) sender;

- (void) setScore: (int) score;

- (void) setLives: (int) lives;

+ (KBGUI *) create: (LevelLayer *) parent;
@end
