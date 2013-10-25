//
//  KBAnimate.h
//  killbills
//
//  Created by Cristian Pereyra on 10/24/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KBGameObject.h"
#import "KBAnimatedSprite.h"

@interface KBAnimate : NSObject

+(void) repeatRotate: (id<KBGameObject>) object
           withAngle: (NSInteger) angle
         andDuration: (double) duration;

+(void) repeatOpacity: (id<KBGameObject>) object
                 from: (NSInteger) startOpacity
                   to: (NSInteger) endOpacity
         withDuration: (double) duration;


+(CCSprite *) buildAnimatedSprite: (NSString *) batchSpriteName
                         withMask: (NSString *) spriteNameMask
                        andAmount: (int) amount;

@end
