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

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

NSMutableArray * _monsters;
NSMutableArray * _projectiles;

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
        [_monsters removeObject:node];
        [node removeFromParentAndCleanup:YES];
       }];
    
    [self addObject:kbmonster];
    
    [_monsters addObject:kbmonster.sprite];
    
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
        [_projectiles removeObject:node];
    }];
    
    [self addObject:projectile];
    
    [_projectiles addObject:[projectile sprite]];
  
    
}

- (void)update:(ccTime)dt {
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    for (CCSprite *projectile in _projectiles) {
        
        NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
        for (CCSprite *monster in _monsters) {
            
            if (CGRectIntersectsRect(projectile.boundingBox, monster.boundingBox)) {
                [monstersToDelete addObject:monster];
            }
        }
    
        for (CCSprite *monster in monstersToDelete) {
            [_monsters removeObject:monster];
            [self removeChild:monster cleanup:YES];
            }
        
        if (monstersToDelete.count > 0) {
            [projectilesToDelete addObject:projectile];
        }
        [monstersToDelete release];
    }
    
    for (CCSprite *projectile in projectilesToDelete) {
        [_projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
    [projectilesToDelete release];
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
