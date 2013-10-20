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

@interface KBMonster : NSObject <KBGameObject> {
    CCSprite * sprite;
}

@property(nonatomic, retain) CCSprite * sprite;

-(int) height;
-(int) width;

-(void) setPosition: (CGSize) size;

+(KBMonster *) create;

@end