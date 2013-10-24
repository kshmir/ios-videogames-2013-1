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

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

NSMutableArray * _monsters;
NSMutableArray * _projectiles;

KBCollisionDetector * _collisionDetector;

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
    
    [self addObject:projectile];
    
    [_collisionDetector registerObject:projectile key:@"projectile"];
}

- (void)update:(ccTime)dt {
    
    [_collisionDetector detectCollisions: ^(id<KBGameObject> gameObject, NSString * key) {
        [self removeChild:[gameObject sprite] cleanup:YES];
    }];
    
}

// on "init" you need to initialize your instance
-(id) init
{
    if ((self = [super initWithColor:ccc4(255,255,255,255)])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *player = [CCSprite spriteWithFile:@"player.png"];
        player.position = ccp(player.contentSize.width/2, winSize.height/2);
        [self addChild:player];
        [self setTouchEnabled:YES];
        
        // Start the schedule for the game logic
        [self schedule:@selector(generateMonsters:) interval:1.0];
        
        _monsters = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
       
       
        NSArray * data = [NSArray arrayWithObject:[NSArray arrayWithObjects:@"monster", @"projectile", nil]];
        
        _collisionDetector = [KBCollisionDetector createWithRelations:data];
        
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
    
    [_monsters release];
    _monsters = nil;
    [_projectiles release];
    _projectiles = nil;
    
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
