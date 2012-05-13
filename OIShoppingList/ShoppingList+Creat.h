//
//  ShoppingList+Creat.h
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "ShoppingList.h"
#import "ListEntry+Creat.h"

@interface ShoppingList (Creat)
+ (ShoppingList *)createShoppingListWithTittle:(NSString *)tittle
                inManagedObjectContext:(NSManagedObjectContext *)context;
- (void)addEntry:(ListEntry *) entryt;
@end
