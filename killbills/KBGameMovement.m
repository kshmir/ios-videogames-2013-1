//
//  KBLinearMovement.m
//  killbills
//
//  Created by Cristian Pereyra on 20/10/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBGameMovement.h"

@implementation KBLinearMovement

- (void) move:(NSObject<KBMovingObject> *)movingObject {
    [[movingObject sprite] runAction:nil];
    return;
}
@end
