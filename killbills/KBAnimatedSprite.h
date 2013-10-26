//
//  KBAnimatedSprite.h
//  killbills
//
//  Created by Cristian Pereyra on 10/25/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface KBAnimatedSprite : NSObject

@property (nonatomic, retain) CCSpriteBatchNode * spriteSheet;
@property (nonatomic, retain) CCSprite * sprite;
@property (nonatomic, retain) NSArray * animFrames;


+(KBAnimatedSprite *) createWithBatch: (NSString *) batchSpriteName
                             withMask: (NSString *) spriteNameMask
                            andAmount: (int) amount;

-(void) setUpdateSpeed: (double) speed;
-(void) setOnlyFrameNumber: (int) frame;
-(void) reanimate;

@end
