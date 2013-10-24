//
//  KBCollisionDetector.h
//  killbills
//
//  Created by Cristian Pereyra on 10/23/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KBGameObject.h"

@interface KBCollisionDetector : NSObject

@property (nonatomic, retain) NSMutableDictionary * items;
@property (nonatomic, retain) NSArray * relations;

+ (KBCollisionDetector *) createWithRelations: (NSArray *) relations;

- (BOOL) unregisterObject: (id<KBGameObject>) object key: (NSString *) string;
- (BOOL) registerObject: (id<KBGameObject>) object key: (NSString *) string;

- (void) detectCollisions: (void (^)(id<KBGameObject>, NSString * key)) block;

@end


@interface KBCollisionRelation : NSObject

@property (nonatomic, retain) NSString * firstKey;
@property (nonatomic, retain) NSString * lastKey;

+ (KBCollisionRelation *) createRelationBetween: (NSString *) firstKey and: (NSString *) lastKey;

@end
