//
//  KBGameObject.h
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "KBGameMovement.h"

@protocol KBGameMovement;
@protocol KBGameObject <NSObject>

@property(nonatomic, retain) CCNode * sprite;

-(CGSize) size;
-(CGPoint) position;

@end


@protocol KBMovingObject <KBGameObject>
@property(nonatomic) double speed;
@property(nonatomic, retain) NSObject<KBGameMovement> * movement;

-(void) move:(void (^) (CCNode *)) block;
@end

