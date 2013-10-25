//
//  KBAnimate.m
//  killbills
//
//  Created by Cristian Pereyra on 10/24/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBAnimate.h"

@implementation KBAnimate

+(void) repeatRotate: (id<KBGameObject>) object
           withAngle: (NSInteger) angle
         andDuration: (double) duration {
    CCAction *rot = [CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:duration angle: angle]];
    [[object sprite]runAction:rot];
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
@end
