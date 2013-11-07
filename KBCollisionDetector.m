//
//  KBCollisionDetector.m
//  killbills
//
//  Created by Cristian Pereyra on 10/23/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import "KBCollisionDetector.h"

@implementation KBCollisionDetector

@synthesize relations;
@synthesize items;

+ (KBCollisionDetector *) createWithRelations: (NSArray *) relations{
    KBCollisionDetector * detector = [[KBCollisionDetector alloc] init];
    
    [detector setRelations: [KBCollisionDetector createRelationsFromArray: relations]];
    [detector setItems: [[NSMutableDictionary alloc] init]];
    
    return detector;
}

+ (NSArray *) createRelationsFromArray: relations {
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:[relations count]];


    for (NSArray * relation in relations) {
        KBCollisionRelation * rel = [KBCollisionRelation createRelationBetween: [relation objectAtIndex:0]
                                                                           and: [relation objectAtIndex:1]];
        [array addObject: rel];
    }
    
    return array;
}

- (BOOL) unregisterObject: (id<KBGameObject>) object key: (NSString *) string {
    NSMutableArray * arrayForKey = [self getArrayForKey:string];
   if ([arrayForKey containsObject:object]) {
        [arrayForKey removeObject:object];
        return YES;
    }
    
    return NO;
}

- (BOOL) registerObject: (id<KBGameObject>) object key: (NSString *) string {
    NSMutableArray * arrayForKey = [self getArrayForKey:string];
   
    if (![arrayForKey containsObject:object]) {
        [arrayForKey addObject:object];
        return YES;
    }
    
    return NO;
}

- (NSMutableArray *) getArrayForKey: (NSString *) key {
    if ([[self items] objectForKey:key] == nil) {
        [[self items] setObject: [[NSMutableArray alloc] init]
                         forKey: key];
    }
   
    return [[self items] objectForKey:key];
}

- (void) detectCollisions: (BOOL (^)(id<KBGameObject>, NSString * key)) block {
    for (KBCollisionRelation * relation in relations) {
        [self detectCollisionsForKeys: [relation firstKey]
                                  and: [relation lastKey]
                            withBlock: block];
    }
}

- (void) detectCollisionsForKeys: (NSString *) firstKey
                             and: (NSString *) lastKey
                       withBlock: (BOOL (^)(id<KBGameObject>, NSString * key)) block {
    NSMutableArray * firstElementsToDelete = [[NSMutableArray alloc] init];

    for (id<KBGameObject> firstItem in [items objectForKey:firstKey]) {
        NSMutableArray * secondElementsToDelete = [[NSMutableArray alloc] init];
        
        for (id<KBGameObject> secondItem in [items objectForKey:lastKey]) {
            if (CGRectIntersectsRect([[firstItem sprite] boundingBox],
                                     [[secondItem sprite] boundingBox])) {
                [secondElementsToDelete addObject:secondItem];
            }
        }
        
        for (id<KBGameObject> secondItem in secondElementsToDelete) {
            if ( block(secondItem, lastKey) ) {
                [[items objectForKey:lastKey] removeObject:secondItem];
            }
        }
        
        if ([secondElementsToDelete count] > 0) {
            [firstElementsToDelete addObject:firstItem];
        }
        
        [secondElementsToDelete release];
    }
    
   
    for (id<KBGameObject> item in firstElementsToDelete) {
        if (block(item, firstKey)) {
            [[items objectForKey:firstKey] removeObject:item];
        }
    }
    
    [firstElementsToDelete release];
}

- (void) dealloc {
    for (KBCollisionRelation * relation in relations) {
        for (id<KBGameObject> object in [items objectForKey: [relation firstKey]]) {
            [[object sprite] setTag:KBO_DEAD];
        };
        for (id<KBGameObject> object in [items objectForKey: [relation lastKey]]) {
            [[object sprite] setTag:KBO_DEAD];
        };
    }
    [super dealloc];
}

@end


@implementation KBCollisionRelation

@synthesize firstKey;
@synthesize lastKey;

+ (KBCollisionRelation *) createRelationBetween: (NSString *) firstKey and: (NSString *) lastKey {
    KBCollisionRelation * relation = [[KBCollisionRelation alloc] init];
    
    [relation setFirstKey: firstKey];
    [relation setLastKey: lastKey];
    
    return relation;
}

@end