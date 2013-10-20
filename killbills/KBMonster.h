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

-(void) setSpeedBetween: (double) speed andBetween: (double) topSpeed;

+(KBMonster *) create;

@end
