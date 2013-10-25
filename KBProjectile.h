//
//  KBProjectile.h
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBGameObject.h"
#import "KBAnimate.h"
#import "KBBaseNode.h"

@interface KBProjectile : KBBaseNode<KBMovingObject>
+(KBProjectile *) create;
@end
