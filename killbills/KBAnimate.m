//
//  KBAnimate.m
//  killbills
//
//  Created by Cristian Pereyra on 10/24/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBAnimate.h"

@implementation KBAnimate

+(void) repeatRotateNode: (CCNode *) sprite
           withAngle: (NSInteger) angle
         andDuration: (double) duration {
    CCAction *rot = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:duration angle: angle]];
    [sprite runAction:rot];
}
+(void) repeatRotate: (id<KBGameObject>) object
           withAngle: (NSInteger) angle
         andDuration: (double) duration {
    [KBAnimate repeatRotateNode:[object sprite] withAngle:angle andDuration:duration];
}

+(void) repeatTint: (CCNode *) sprite
             fromR: (NSInteger) fromR
             fromG: (NSInteger) fromG
             fromB: (NSInteger) fromB
             toR: (NSInteger) toR
             toG: (NSInteger) toG
             toB: (NSInteger) toB
         withDuration: (double) duration
{

    CCActionInterval * action = [CCSequence actions:
                                   [CCTintTo actionWithDuration:duration red:fromR green:fromG blue:fromB],
                                   [CCTintTo actionWithDuration:duration red:toR green:toG blue:toB], nil];
    
    CCAction *tint = [CCRepeatForever actionWithAction:action];

    [sprite runAction:tint];
}
+(void) toggleOpacity: (CCNode *) sprite
                 from: (NSInteger) startOpacity
                   to: (NSInteger) endOpacity
         withDuration: (double) duration
                times: (NSUInteger) times {

    CCFiniteTimeAction * action = [CCSequence actions:
                                   [CCFadeTo actionWithDuration:duration opacity:startOpacity],
                                   [CCFadeTo actionWithDuration:duration opacity:endOpacity], nil];
    CCAction *fade = [CCRepeat actionWithAction:action times: times];

    [sprite runAction:fade];
}
+(void) repeatOpacity: (id<KBGameObject>) object
                 from: (NSInteger) startOpacity
                   to: (NSInteger) endOpacity
         withDuration: (double) duration {
 
    CCAction *fade = [CCRepeatForever actionWithAction:[CCSequence actions:
                                                        [CCFadeTo actionWithDuration:duration opacity:startOpacity],
                                                        [CCFadeTo actionWithDuration:duration opacity:endOpacity],
                                                        nil]];

    [[object sprite]runAction:fade];
}

+(void) increaseScale: (id<KBGameObject>) object
                   by: (double) amount
         withDuration: (double) duration {
    
    CCAction *scale = [CCRepeatForever actionWithAction:[CCSequence actions:
                                                        [CCScaleBy actionWithDuration:duration scale:amount], nil]];

    [[object sprite]runAction:scale];
}

@end
