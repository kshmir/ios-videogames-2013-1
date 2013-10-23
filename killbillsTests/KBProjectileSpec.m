//
//  KBProjectileSpec.m
//  killbills
//
//  Created by Cristian Pereyra on 23/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "SpecHelper.m"

#import "KBProjectile.h"

SpecBegin(KBProjectile)

describe(@"KBProjectile", ^{
    
    __block KBProjectile *projectile;
    
    beforeEach(^{
        projectile = [KBProjectile create];
    });
    
    itBehavesLike(@"a moving object", ^{
        return [NSDictionary dictionaryWithObjectsAndKeys:projectile, @"movingObject", nil];
    });
    itBehavesLike(@"a game object", ^{
        return [NSDictionary dictionaryWithObjectsAndKeys:projectile, @"gameObject", nil];
    });
});

SpecEnd