//
//  KBGameObject.h
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KBGameObject <NSObject>

@property(nonatomic, retain) CCSprite * sprite;

-(int) height;
-(int) width;

-(void) setPosition: (CGSize) size;

@end


@protocol KBMovingObject <KBGameObject>
@property(nonatomic) float speed;
@end
