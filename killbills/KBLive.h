//
//  KBLive.h
//  killbills
//
//  Created by Cristian Pereyra on 10/28/13.
//  Copyright (c) 2013 Cristian Pereyra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KBBaseNode.h"

@interface KBLive : KBBaseNode

+(KBLive *) create;

-(void) calculatePosition;

@end
