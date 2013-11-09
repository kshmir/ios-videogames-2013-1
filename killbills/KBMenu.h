//
//  KBMenu.h
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class LevelLayer;

@interface KBMenu : NSObject
-(CCMenu *) menu;

-(void) resumeClicked;

-(void) toggle;
+(KBMenu *) create: (LevelLayer *) forScene;
@end
