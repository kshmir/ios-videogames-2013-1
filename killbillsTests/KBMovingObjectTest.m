//
//  KBMonsterTest.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "SpecHelper.m"
#import "KBMonster.h"

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
        expect([monster speed]).to.beGreaterThanOrEqualTo(0.2);
    });
    
    itBehavesLike(@"a moving object", [NSDictionary dictionaryWithObjectsAndKeys:monster, @"movingObject", nil]);
    itBehavesLike(@"a game object", [NSDictionary dictionaryWithObjectsAndKeys:monster, @"gameObject", nil]);
});

SpecEnd
