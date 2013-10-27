//
//  HelloWorldLayer.m
//  killbills
//
//  Created by Cristian Pereyra on 12/09/13.
//  Copyright Cristian Pereyra 2013. All rights reserved.
//


#include <OpenGLES/ES1/gl.h>
// Import the interfaces
#import "LevelLayer.h"

// Needed to obtain the Navigation Controller
#import "KBAppDelegate.h"
#import "KBMonster.h"
#import "KBGameObject.h"
#import "KBProjectile.h"
#import "KBCollisionDetector.h"
#import "KBPlayer.h"
#import "KBMenu.h"
#import "KBGUI.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation LevelLayer {
   
    KBCollisionDetector * _collisionDetector;
    KBPlayer * _player;
    
    KBMenu * _menu;
    KBGUI * _gui;
    
    int score;
    
    int multiplier;
    
    double lastHitTime;
    
    double projectileStartTime;
    BOOL specialProjectile;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	LevelLayer *layer = [LevelLayer node];
	[scene addChild: layer];
	return scene;
}

- (void) addObject: (id<KBGameObject>) content {
    [self addChild: [content sprite]];
}

- (void) addMonster {
    KBMonster * kbmonster = [KBMonster create];
    
    [kbmonster setSpeedBetween:50 andBetween:200];
    [kbmonster move: ^(CCNode *node) {
        [_collisionDetector unregisterObject:kbmonster key:@"monster"];
        [node removeFromParentAndCleanup:YES];
    }];
    
    [self addObject:kbmonster];
    
    [_collisionDetector registerObject:kbmonster key:@"monster"];
    
}

-(void) generateMonsters:(ccTime)dt {
    [self addMonster];
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self->_player prepareProjectile];
    self->projectileStartTime = CACurrentMediaTime();
}

- (void) onAnimationEnded {
   [self->_player reanimate];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    double diff = CACurrentMediaTime() - self->projectileStartTime;
    
    if (diff > 0.9) {
        self->specialProjectile = YES;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    KBProjectile * projectile = [KBProjectile create];
    
    [projectile setSpecial: self->specialProjectile];
    
    self->specialProjectile = NO;
    CGPoint offset = ccpSub(touchLocation, projectile.position);
    
    if (offset.x <= 0) return;
    
    
    KBTouchMovement * movement = [KBTouchMovement allocWithMovingObject:projectile andTouchOffset: offset];
    
    [projectile setMovement: movement];
    [projectile move: ^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        [_collisionDetector unregisterObject:projectile key:@"projectile"];
        self->multiplier = 0;
    }];
    
    int sizeRate = ([projectile special]) ? 5 : 2;
    
    [KBAnimate increaseScale:projectile by:sizeRate withDuration:[movement duration]];
    
    [self scheduleOnce:@selector(onAnimationEnded) delay:0.25];
    
    [self->_player launchProjectile];
    
    [self addObject:projectile];
    
    [_collisionDetector registerObject:projectile key:@"projectile"];
}


- (void) incrementScoreBy: (int) incrementSize {
    [self setScore:(self->score + incrementSize)];
}

- (void) setScore: (int) aScore {
    self->score = aScore;
    [self->_gui setScore: score];
}

- (void)update:(ccTime)dt {
   
    [_collisionDetector detectCollisions: ^(id<KBGameObject> gameObject, NSString * key) {
        if ([key isEqual:@"monster"]) {
            NSTimeInterval newInterval = CACurrentMediaTime();
            NSTimeInterval difference = newInterval - self->lastHitTime;
            
            if (difference < 2.00) {
                self->multiplier += 1;
            } else {
                self->multiplier = 0;
            }
            
            self->lastHitTime = newInterval;
            [self incrementScoreBy:(100 * (multiplier + 1) * (multiplier + 1))];
            
            CCParticleSystemQuad * el = [CCParticleSystemQuad particleWithFile:@"particle.plist"];
            [el setBlendFunc:(ccBlendFunc){GL_ZERO,GL_ONE_MINUS_SRC_COLOR}];
            [el setDuration:0.5];
            [el setPosition:[[gameObject sprite] position]];
            [el setAutoRemoveOnFinish:YES];
            [self addChild: el z:10];
        }
        if ([key isEqual:@"projectile"]) {
            if ([gameObject special]) {
                return NO;
            }
        }
        [self removeChild:[gameObject sprite] cleanup:YES];
        return YES;
    }];
    
}

-(KBMenu *) menu {
    return self->_menu;
}


// on "init" you need to initialize your instance
-(id) init
{
    if ((self = [super initWithColor:ccc4(255,255,255,255)])) {
        self->_player = [KBPlayer create];
        [self addChild:[self->_player sprite]];
        
        self->_menu = [KBMenu create: self];
        [self addChild:[self->_menu menu]];
        
        self->_gui = [KBGUI create: self];
        [self addChild:[self->_gui gui]];
        
        [self setTouchEnabled:YES];

        [[[self menu] menu] setVisible:NO];
       
        self->lastHitTime = CACurrentMediaTime();
        
        NSArray * data = @[@[@"monster", @"projectile"]];
        
        _collisionDetector = [KBCollisionDetector createWithRelations:data];
        
        [self schedule:@selector(generateMonsters:) interval:1.0];
        [self schedule:@selector(update:)];
        
    }
    
	return self;
}
@end