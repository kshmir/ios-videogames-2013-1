//
//  KBGUI.m
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBGUI.h"
#import "HelloWorldLayer.h"

@implementation KBGUI
{
    CCNode * _gui;
    HelloWorldLayer * _parent;
}

- (CCNode *) gui {
    return self->_gui;
}


-(void) resumeClick:(id)sender {
    [[_parent menu] toggle];
}


+ (KBGUI *) create: (CCLayerColor *) parent {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    KBGUI * gui = [[KBGUI alloc] init];
    
    gui->_parent = parent;
    
  
    // Standard method to create a button
    
    
    CCMenuItem * menuItem = [CCMenuItemImage
                             itemWithNormalImage:@"pause.png"
                             selectedImage:@"pause.png"
                             target:self
                             selector:@selector(resumeClick:)];
    
    [menuItem setScale: 0.15];
    [menuItem setPosition:ccp(winSize.width - [menuItem contentSize].width * 0.1,[menuItem contentSize].height * 0.1)];
    CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
    [menuItem setTarget:gui selector:@selector(resumeClick:)];
    menu.position = CGPointZero;
    
    gui->_gui = menu;
    
    
    
    
    return gui;
}
@end
