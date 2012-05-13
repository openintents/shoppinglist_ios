//
//  ShoppingList+Creat.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 11/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "ShoppingList+Creat.h"

@implementation ShoppingList (Creat)
+ (ShoppingList *)createShoppingListWithTittle:(NSString *)tittle
                  inManagedObjectContext:(NSManagedObjectContext *)context;
{
    ShoppingList  *shoppingList = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ShoppingList"];
    request.predicate = [NSPredicate predicateWithFormat:@"tittle = %@", tittle];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tittle" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *shoppingLists = [context executeFetchRequest:request error:&error];
    
    if (!shoppingLists || ([shoppingLists count] > 1)) {
        // handle error
    } else if (![shoppingLists count]) {
        shoppingList = [NSEntityDescription insertNewObjectForEntityForName:@"ShoppingList"
                                                     inManagedObjectContext:context];
        shoppingList.tittle=tittle;
    } else {
        shoppingList   = [shoppingLists lastObject];
    }
    
    return shoppingList;
}

- (void) addEntry:(ListEntry *) entry
{
    if(!self.needToBuy)
        self.needToBuy=[[NSSet alloc] init];
    self.needToBuy = [self.needToBuy setByAddingObject: entry];
    NSLog(@"List[%@] added entry [%@]",self.tittle,entry.tittle);
}

@end
