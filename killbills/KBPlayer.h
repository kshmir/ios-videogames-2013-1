//
//  KBPlayer.h
//  killbills
//
//  Created by Cristian Pereyra on 10/26/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBBaseNode.h"

@interface KBPlayer : KBBaseNode

+(KBPlayer *) create;

- (CCSprite *) actualSprite;
- (void) prepareProjectile;
- (void) launchProjectile;
- (void) reanimate;

@end
