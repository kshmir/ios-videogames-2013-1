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
#import "IntroLayer.h"


// Needed to obtain the Navigation Controller

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation LevelLayer {
   
    KBCollisionDetector * _collisionDetector;
    KBPlayer * _player;
    
    KBMenu * _menu;
    KBGUI * _gui;
    
    int score;
    
    int lives;
    
    int levelNumber;
    
    int multiplier;
    
    int monstersToKill;
    
    int monstersSpawned;
    double lastHitTime;
    
    double projectileStartTime;
    BOOL specialProjectile;
}

const int BOSS_LEVEL = 5;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.

+(CCScene *) sceneFromLevelLayer: (LevelLayer *) aLayer
{
	CCScene *scene = [CCScene node];
	LevelLayer *layer = [LevelLayer node];
    layer->levelNumber = aLayer->levelNumber + 1;
    layer->score = aLayer->score;
    [layer->_gui setScore: layer->score];
    [layer->_gui setLevelNumber: layer->levelNumber];
	[scene addChild: layer];
	return scene;
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	LevelLayer *layer = [LevelLayer node];
    layer->levelNumber = layer->levelNumber + 1;
    [layer->_gui setLevelNumber: layer->levelNumber];
	[scene addChild: layer];
	return scene;
}

- (void) addObject: (id<KBGameObject>) content {
    [self addChild: [content sprite]];
}

- (void) showGameOver {
    [[CCDirector sharedDirector] replaceScene:[GameOverLayer scene]];
}

- (void)prepareMonster:(KBMonster *)kbmonster {
    [kbmonster move: ^(CCNode *node) {
        [_collisionDetector unregisterObject:kbmonster key:@"monster"];
        [node removeFromParentAndCleanup:YES];
        [[self scheduler] unscheduleAllForTarget:kbmonster];
        [self setLives:lives - 1];
    }];
    
    [self addObject:kbmonster];
    
    [_collisionDetector registerObject:kbmonster key:@"monster"];
}

- (BOOL) bossLevel {
    return (self->levelNumber) % BOSS_LEVEL == 0;
}

- (void) addMonster {
    double r = (rand() * 1.0 / RAND_MAX) * (10);
    
    KBMonster * kbmonster;
    if ([self bossLevel] == NO) {
        if (r > 7 && r < 8) {
            kbmonster = [KBMonster createBerserk: self];
        } else if (r > 8) {
            kbmonster = [KBMonster createSpeeder: self];
        } else {
            kbmonster = [KBMonster create];
        }
    } else {
        if (self->monstersSpawned > 0) {
            return;
        }
        kbmonster = [KBMonster createBoss: self];
    
    }
    [kbmonster setSpeedBetween:(50 + self->levelNumber * 10) andBetween:(200 + self->levelNumber * 15)];
    
    [self prepareMonster:kbmonster];
    self->monstersSpawned++;
}

- (void) addChildMonster {
    for (int i = 0; i < 10; i++) {
        KBMonster * kbmonster = [KBMonster create];
        [kbmonster setSpeedBetween:(25 + (self->levelNumber - 1) * 8)
                        andBetween:(75 + (self->levelNumber - 1) * 12)];
        [self prepareMonster:kbmonster];
    }
}


- (void) addChildMonsterBoss {
    for (int i = 0; i < 40; i++) {
        KBMonster * kbmonster = [KBMonster create];
        [kbmonster setSpeedBetween:(25 + (self->levelNumber) * 50)
                        andBetween:(75 + (self->levelNumber) * 150)];
        [self prepareMonster:kbmonster];
    }
}


- (void) setLives: (int) liv {
    self->lives = liv;
    [_gui setLives:liv];
    
    if (liv == 0) {
        [self showGameOver];
    }
}

-(void) maybeAddLive {
    double r = (rand() * 1.0 / RAND_MAX) * (10);
    
    if (r > 9) {
        KBLive * live = [KBLive create];
        
        [live setSpeed:100];
        
        [live move: ^(CCNode *node) {
            [_collisionDetector unregisterObject:live key:@"live"];
            [node removeFromParentAndCleanup:YES];
            [self setLives:lives - 1];
        }];
        
        [self addObject:live];
        
        [_collisionDetector registerObject:live key:@"live"];
    }
}

-(void) generateMonsters:(ccTime)dt {
    [self addMonster];
    
    [self maybeAddLive];
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self->_player prepareProjectile];
    self->projectileStartTime = CACurrentMediaTime();
}

- (void) onAnimationEnded {
   [self->_player reanimate];
}

- (void) removeObject: (id<KBGameObject>) object {
    [_collisionDetector unregisterObject:object key:@"monster"];
    [[object sprite] removeFromParentAndCleanup:YES];
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
    
    [self scheduleOnce:@selector(onAnimationEnded) delay:1];
    
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

- (void) animateExplosion:(id)gameObject {
    CCParticleSystemQuad * el = [CCParticleSystemQuad particleWithFile:@"particle.plist"];
    [el setBlendFunc:(ccBlendFunc){GL_ZERO,GL_ONE_MINUS_SRC_COLOR}];
    [el setDuration:0.5];
    [el setPosition:[[gameObject sprite] position]];
    [el setAutoRemoveOnFinish:YES];
    [self addChild: el z:10];
}

- (void) increaseLevel {
    [self moveToLevel:self->levelNumber + 1];
}

- (void) moveToLevel: (int) level {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LevelLayer sceneFromLevelLayer:self]]];
}

- (void) decreaseMonstersKilled {
    self->monstersToKill--;
    if (self->monstersToKill == 0) {
        [self increaseLevel];
    }
}

- (void)update:(ccTime)dt {
   
    [_collisionDetector detectCollisions: ^(id<KBGameObject> gameObject, NSString * key) {
        
        if ([key isEqual:@"live"]) {
            [self setLives: lives + 1];
        }
        
        if ([key isEqual:@"monster"]) {
            NSTimeInterval newInterval = CACurrentMediaTime();
            NSTimeInterval difference = newInterval - self->lastHitTime;
           
            KBMonster * monster = (KBMonster * ) gameObject;
            
            if ([monster type] == KBM_BOSS) {
                if ([monster liveCount] > 0) {
                    [monster setLiveCount:[monster liveCount] - 1];
                    return NO;
                } else {
                    self->monstersToKill = 1;
                    [self decreaseMonstersKilled];
                }
            }
            
            if (difference < 2.00) {
                self->multiplier += 1;
            } else {
                self->multiplier = 0;
            }
            
            self->lastHitTime = newInterval;
            [self incrementScoreBy:(100 * (multiplier * 0.2 + 1) * (multiplier * 0.2 + 1))];
            
            [self animateExplosion:gameObject];
            
            [[gameObject sprite] setTag:KBO_DEAD];
            [self decreaseMonstersKilled];
            [[self scheduler] unscheduleAllForTarget:gameObject];
        }
        if ([key isEqual:@"projectile"]) {
            if ([gameObject special]) {
                return NO;
            }
        }
        
        [self removeChild:[gameObject sprite] cleanup:YES];
        [self decreaseMonstersKilled];
        return YES;
    }];
    
}

-(KBMenu *) menu {
    return self->_menu;
}


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
        
        self->lives = 5;
        self->monstersToKill = 30;
        
        _collisionDetector = [KBCollisionDetector createWithRelations:@[@[@"monster", @"projectile"],@[@"live", @"projectile"]]];
        
        [self schedule:@selector(generateMonsters:) interval:1];
        [self schedule:@selector(update:)];
        
    }
    
	return self;
}

- (void) dealloc {
    [[self scheduler] unscheduleAllForTarget:self];
    [_collisionDetector dealloc];
    [super dealloc];
}
@end
