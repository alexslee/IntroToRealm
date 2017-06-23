//
//  Furniture.h
//  IntroToRealm
//
//  Created by Alex Lee on 2017-06-23.
//  Copyright © 2017 Alex Lee. All rights reserved.
//

#import <Realm/Realm.h>
@class Room;

@interface Furniture : RLMObject

@property Room *room;

@property NSString *name;

@end

RLM_ARRAY_TYPE(Furniture)
