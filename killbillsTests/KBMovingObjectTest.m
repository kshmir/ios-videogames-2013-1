//
//  KBMonsterTest.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "SpecHelper.m"

#import "KBGameMovement.h"
#import "KBMonster.h"
#import "KBProjectile.h"

SharedExamplesBegin(KBMovingObject)

sharedExamplesFor(@"a moving object", ^(NSDictionary * data) {
    it(@"respects the protocol", ^{
        id<KBMovingObject> object = [data objectForKey:@"movingObject"];
        expect(object).to.conformTo(@protocol(KBMovingObject));
    });
    it(@"should have a movement object", ^{
        id<KBMovingObject> object = [data objectForKey:@"movingObject"];
        expect([object movement]).notTo.beNil();
    });
});

SharedExamplesEnd

SharedExamplesBegin(KBGameObject)

sharedExamplesFor(@"a game object", ^(NSDictionary * data) {
    it(@"respects the protocol", ^{
        id<KBMovingObject> object = [data objectForKey:@"gameObject"];
        expect(object).to.conformTo(@protocol(KBGameObject));
    });
    it(@"should have a sprite object", ^{
        id<KBMovingObject> object = [data objectForKey:@"gameObject"];
        expect([object sprite]).notTo.beNil();
    });
});

SharedExamplesEnd

SpecBegin(KBMonster)

describe(@"KBMonster", ^{
    __block KBMonster *monster;
    
    beforeEach(^{
        monster = [KBMonster create];
    });
    
    it(@"should set the height and weight of the sprite it contains", ^{
        expect([monster sprite].contentSize.height).to.equal([monster size].height);
        expect([monster sprite].contentSize.width).to.equal([monster size].width);
    });
    
    it(@"should allow to set a speed between some values", ^{
        [monster setSpeedBetween:0.1 andBetween:0.2];
        expect([monster speed]).to.beGreaterThanOrEqualTo(0.1);
        expect([monster speed]).to.beLessThanOrEqualTo(0.2);
    });
    
    itBehavesLike(@"a moving object", ^{
        return [NSDictionary dictionaryWithObjectsAndKeys:monster, @"movingObject", nil];
    });
    itBehavesLike(@"a game object", ^{
        return [NSDictionary dictionaryWithObjectsAndKeys:monster, @"gameObject", nil];
    });
});
describe(@"KBProjectile", ^{
    __block KBProjectile * projectile;
    
    beforeEach(^{
        projectile = [KBProjectile create];
    });
    
    it(@"should set the height and weight of the sprite it contains", ^{
        expect([projectile sprite].contentSize.height).to.equal([projectile size].height);
        expect([projectile sprite].contentSize.width).to.equal([projectile size].width);
    });
    
    itBehavesLike(@"a moving object", ^{
        return [NSDictionary dictionaryWithObjectsAndKeys:projectile, @"movingObject", nil];
    });
    itBehavesLike(@"a game object", ^{
        return [NSDictionary dictionaryWithObjectsAndKeys:projectile, @"gameObject", nil];
    });
});
SpecEnd
