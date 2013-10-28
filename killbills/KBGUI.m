//
//  KBGUI.m
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBGUI.h"
#import "LevelLayer.h"

@implementation KBGUI
{
    CCNode * _gui;
    LevelLayer * _parent;
    CCLabelTTF * _scoreLabel;
    CCLabelTTF * _levelLabel;
}

- (CCNode *) gui {
    return self->_gui;
}


-(void) resumeClick:(id)sender {
    [[_parent menu] toggle];
}


- (void) setScore: (int) score {
    [self->_scoreLabel setString:[NSString stringWithFormat:@"%d", score]];
}


- (void) setLives: (int) lives {
    [self->_levelLabel setString:[NSString stringWithFormat:@"x %d", lives]];
}


+ (KBGUI *) create: (LevelLayer *) parent {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    KBGUI * gui = [[KBGUI alloc] init];
    
    gui->_parent = parent;
    
    // Standard method to create a button
   
    CCLabelTTF * scoreText = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana" fontSize:14.0];
    
    [scoreText setColor:ccc3(0,0,0)];
    [scoreText setPosition:ccp(winSize.width / 2, [scoreText contentSize].height)];
    
    CCSprite * live = [CCSprite spriteWithFile:@"live.png"];
    [live setScale: 0.5];
    CCLabelTTF * liveCount = [CCLabelTTF labelWithString:@"x 5" fontName:@"Verdana" fontSize:14.0];
    [liveCount setColor:ccc3(0,0,0)];
    
    [liveCount setPosition:ccp(winSize.width / 2 + [live contentSize].width / 2,
                              (winSize.height) - [live contentSize].height * 0.75)];
    [live setPosition:ccp(winSize.width / 2 - [live contentSize].width / 4,
                              (winSize.height) - [live contentSize].height * 0.75)];
    
    CCMenuItem * menuItem = [CCMenuItemImage
                             itemWithNormalImage:@"pause.png"
                             selectedImage:@"pause.png"
                             target:self
                             selector:@selector(resumeClick:)];
    
    [menuItem setScale: 0.15];
    [menuItem setPosition:ccp(winSize.width - [menuItem contentSize].width * 0.1,[menuItem contentSize].height * 0.1)];
    [menuItem setTarget:gui selector:@selector(resumeClick:)];
    
    CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
    
    menu.position = CGPointZero;
    
    [scoreText setZOrder:100];
    [live      setZOrder:100];
    [liveCount setZOrder:100];
    
    [parent addChild:scoreText];
    [parent addChild:live];
    [parent addChild:liveCount];
  
    gui->_levelLabel = liveCount;
    gui->_scoreLabel = scoreText;
    gui->_gui = menu;
    
    [gui->_gui setZOrder:100];
    [gui->_scoreLabel setZOrder:100];
    
    return gui;
}
@end
