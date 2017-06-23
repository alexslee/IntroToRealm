//
//  Room.h
//  IntroToRealm
//
//  Created by Alex Lee on 2017-06-23.
//  Copyright © 2017 Alex Lee. All rights reserved.
//
#import <Realm/Realm.h>
#import "Furniture.h"

@interface Room : RLMObject

@property NSString *name;

@property RLMArray<Furniture *><Furniture> *furnitureList;

@end

RLM_ARRAY_TYPE(Room)
