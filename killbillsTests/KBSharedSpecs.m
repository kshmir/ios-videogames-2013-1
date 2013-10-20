#import "SpecHelper.m"
#import "KBGameObject.h"

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