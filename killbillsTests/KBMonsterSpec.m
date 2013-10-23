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
SpecEnd
