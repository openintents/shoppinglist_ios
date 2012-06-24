//
//  Lists+Manage.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Lists.h"
#import "Items+Manage.h"
#import "Contains+Manage.h"

@interface Lists (Manage)
+ (Lists *)createShoppingListWithName:(NSString *)name
               inManagedObjectContext:(NSManagedObjectContext *)context;
- (void) addItemWithName: (NSString*) itemName 
  inManagedObjectContext:(NSManagedObjectContext*)context;

@end
