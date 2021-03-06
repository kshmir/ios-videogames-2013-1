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
- (void) run:(void (^) (CCNode *)) block;
@end

@interface KBLinearMovement : NSObject <KBGameMovement>

@property (nonatomic, strong) id<KBMovingObject> object;

+ (KBLinearMovement *) allocWithMovingObject: (id<KBMovingObject>) object;

@end

@interface KBTouchMovement : NSObject <KBGameMovement>

@property (nonatomic, strong) id<KBMovingObject> object;
@property (nonatomic) CGPoint touchOffset;

- (double) duration;

+ (KBTouchMovement *) allocWithMovingObject: (id<KBMovingObject>) object andTouchOffset: (CGPoint) touchLocation;

@end