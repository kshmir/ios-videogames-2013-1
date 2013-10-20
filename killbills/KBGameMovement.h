//
//  KBMovement.h
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KBGameObject.h"

@protocol KBMovingObject;

@protocol KBGameMovement <NSObject>
- (void) move: (NSObject<KBMovingObject> *) movingObject;
@end

@interface KBLinearMovement : NSObject <KBGameMovement>

@end