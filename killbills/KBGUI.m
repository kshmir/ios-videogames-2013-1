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


+ (KBGUI *) create: (LevelLayer *) parent {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    KBGUI * gui = [[KBGUI alloc] init];
    
    gui->_parent = parent;
    
    // Standard method to create a button
   
    CCLabelTTF * scoreText = [CCLabelTTF labelWithString:@"0" fontName:@"Verdana" fontSize:14.0];
    
    [scoreText setColor:ccc3(0,0,0)];
    [scoreText setPosition:ccp(winSize.width / 2, [scoreText contentSize].height)];
    
    CCMenuItem * menuItem = [CCMenuItemImage
                             itemWithNormalImage:@"pause.png"
                             selectedImage:@"pause.png"
                             target:self
                             selector:@selector(resumeClick:)];
    
    [menuItem setScale: 0.15];
    [menuItem setPosition:ccp(winSize.width - [menuItem contentSize].width * 0.1,[menuItem contentSize].height * 0.1)];
   
    [parent addChild:scoreText];
    
    CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
    [menuItem setTarget:gui selector:@selector(resumeClick:)];
    menu.position = CGPointZero;
   
    gui->_scoreLabel = scoreText;
    gui->_gui = menu;
    
    [gui->_gui setZOrder:100];
    [gui->_scoreLabel setZOrder:100];
    
    
    
    
    return gui;
}
@end
