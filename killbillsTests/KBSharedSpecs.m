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
        id<KBGameObject> object = [data objectForKey:@"gameObject"];
        expect(object).to.conformTo(@protocol(KBGameObject));
    });
    it(@"should have a sprite object", ^{
        id<KBGameObject> object = [data objectForKey:@"gameObject"];
        expect([object sprite]).notTo.beNil();
    });
    
    it(@"should set the height and weight of the sprite it contains", ^{
        id<KBGameObject> object = [data objectForKey:@"gameObject"];
        expect([object sprite].contentSize.height).to.equal([object size].height);
        expect([object sprite].contentSize.width).to.equal([object size].width);
    });
});

SharedExamplesEnd