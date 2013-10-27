//
//  KBMenu.m
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBMenu.h"

@implementation KBMenu {
    __strong CCMenu * menu;
    __strong CCLayer * scene;
    bool paused;
}

-(CCMenu *) menu {
    return self->menu;
}

-(void) resumeClicked {
    [self toggle];
}

-(BOOL) paused {
    return self->paused;
}

-(void) toggle {
    if (!self->paused) {
        [scene setTouchEnabled:NO];
        [[self menu] setVisible:YES];
        [[scene scheduler] setTimeScale:0];
    } else {
        [scene setTouchEnabled:YES];
        [[self menu] setVisible:NO];
        [[scene scheduler] setTimeScale:1];
    }
    
    self->paused = !self->paused;
}

+(KBMenu *) create: (CCLayer *) forLayer {
    KBMenu * menu = [[KBMenu alloc] init];
    
    CCLabelTTF *lbl_Home = [CCLabelTTF labelWithString:@"Resume" fontName:@"verdana" fontSize:25];
   
    [lbl_Home setColor:ccc3(0,0,0)];
    
    CCMenuItemLabel *lbl = [CCMenuItemLabel itemWithLabel:lbl_Home target:menu selector:@selector(resumeClicked)];
    CCMenu *mnu = [CCMenu menuWithItems:lbl,nil];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    [mnu setPosition:ccp(winSize.width/2,winSize.height/2)];
    [mnu alignItemsVertically];
    
    menu->menu = mnu;
    menu->paused = NO;
    menu->scene = forLayer;
    
    return menu;
}
@end
