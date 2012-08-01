//
//  Lists+Manage.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 19/6/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Lists+Manage.h"

@implementation Lists (Manage)

/* @"subtotal",@"availablePrice"*/
- (NSSet*)getStoreWisePriceDescription
{
        
    NSMutableSet*result = [[NSMutableSet alloc]init];
    for (Stores* someStore in self.store_id) {
        [result addObject:[someStore subtotalForItemsAndCalculatedItemsWithinStore]];
    }
         return [[NSSet alloc]initWithSet:result];
    }

+ (Lists *)createShoppingListWithName:(NSString *)name
               inManagedObjectContext:(NSManagedObjectContext *)context
{
    Lists  *shoppingList = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Lists"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *shoppingLists = [context executeFetchRequest:request error:&error];
    
    if (!shoppingLists || ([shoppingLists count] > 1)) {
        // handle error
    } else if (![shoppingLists count]) {
        shoppingList = [NSEntityDescription insertNewObjectForEntityForName:@"Lists"
                                                     inManagedObjectContext:context];
        shoppingList.name=name;
        shoppingList.created= [NSDate date];
        shoppingList.modified = [NSDate date];
        shoppingList.accessed = [NSDate date];
    } else {
        shoppingList   = [shoppingLists lastObject];
        shoppingList.accessed = [NSDate date];
    }
    
    return shoppingList;
    
}
- (void) addItemWithName: (NSString*) itemName 
inManagedObjectContext:(NSManagedObjectContext*)context 
{
    Contains* contain=nil;
    Items* item = nil;
    
    item=[Items creatItemsWithName:itemName inManagedObjectContext:context];
    contain= [Contains creatContainsBetweenItem:item andList:self inManagedObjectContext:context];

    
}
@end
