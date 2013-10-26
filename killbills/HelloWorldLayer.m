//
//  HelloWorldLayer.m
//  killbills
//
//  Created by Cristian Pereyra on 12/09/13.
//  Copyright Cristian Pereyra 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

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
@implementation HelloWorldLayer {
   
    KBCollisionDetector * _collisionDetector;
    KBPlayer * _player;
    KBMenu * _menu;
    KBGUI * _gui;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
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
}

- (void) onAnimationEnded {
   [self->_player reanimate];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    KBProjectile * projectile = [KBProjectile create];
    
    CGPoint offset = ccpSub(touchLocation, projectile.position);
    
    if (offset.x <= 0) return;
    
    [projectile setMovement:[KBTouchMovement allocWithMovingObject:projectile andTouchOffset: offset]];
    
    [projectile move: ^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        [_collisionDetector unregisterObject:projectile key:@"projectile"];
    }];
    
    [self scheduleOnce:@selector(onAnimationEnded) delay:0.25];
    
    [self->_player launchProjectile];
    
    [self addObject:projectile];
    
    [_collisionDetector registerObject:projectile key:@"projectile"];
}

- (void)update:(ccTime)dt {
    
    [_collisionDetector detectCollisions: ^(id<KBGameObject> gameObject, NSString * key) {
        [self removeChild:[gameObject sprite] cleanup:YES];
    }];
    
}

-(void) homeClicked1 {
    
}

-(void) homeClicked2 {
    
}

-(void) homeClicked3 {
    
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
        
        NSArray * data = @[@[@"monster", @"projectile"]];
        _collisionDetector = [KBCollisionDetector createWithRelations:data];
        
        [self schedule:@selector(generateMonsters:) interval:1.0];
        [self schedule:@selector(update:)];
    }
    
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    
    
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	KBAppDelegate *app = (KBAppDelegate*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	KBAppDelegate *app = (KBAppDelegate*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
