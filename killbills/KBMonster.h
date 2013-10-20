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

@interface KBMonster : NSObject <KBMovingObject> {
    CCSprite * _sprite;
    double _speed;
}

@property(nonatomic, retain) CCSprite * sprite;

@property(nonatomic) double speed;
-(int) height;
-(int) width;

-(void) setPosition: (CGSize) size;

+(KBMonster *) create;

@end
