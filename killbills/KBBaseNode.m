//
//  KBBaseNode.m
//  killbills
//
//  Created by Cristian Pereyra on 10/25/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBBaseNode.h"
#import "KBGameMovement.h"

@implementation KBBaseNode 

- (CGPoint) position {
    return self.sprite.position;
}

- (CGSize) size {
    return self.sprite.contentSize;
}

- (void) move:(void (^) (CCNode *)) block {
    [self.movement run: block];
}


- (void)dealloc
{
    [self.sprite dealloc];
    [super dealloc];
}

@end
