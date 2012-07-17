//
//  Stores+Manage.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 13/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "Stores+Manage.h"

@implementation Stores (Manage)

+(Stores*)getStoreWithName:(NSString*)name 
                    inList:(Lists*)list
    inManagedObjectContext:(NSManagedObjectContext*)context
{
    Stores* store = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Stores"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@ AND list_id = %@", name, list];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *storeArray = [context executeFetchRequest:request error:&error];
    
    if (!storeArray || ([storeArray count] > 1)) {
        // handle error
        NSLog(@"error occur");
    } else if (![storeArray count]) {
        store = [NSEntityDescription insertNewObjectForEntityForName:@"Stores"
                                             inManagedObjectContext:context];
        store.name = name;
        store.list_id = list;    
        store.created= [NSDate date];
        store.modified = [NSDate date];
        NSLog(@"added new Store =====%@", [store description]);
    } else {
        store  = [storeArray lastObject];
        NSLog(@"existed Store:===>\nR%@", [store description]);
        
    }
    
    return store;
    
}
-(NSNumber*)priceForItem:(Items*)item
{
    Itemsstores * itemsstore = nil;
    for (itemsstore in self.itemstores_id) {
        if (itemsstore.item_id == item) {
            return itemsstore.price;
        }
    }
    return nil;
}

@end
