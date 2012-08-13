//
//  Itemsstores+Manage.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 13/7/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//
/**************
 This category adds methods to the generated class"Itemsstores", so that these methods won't be "erased" when regenarating the class
 *************/
#import "Itemsstores+Manage.h"
@implementation Itemsstores (Manage)

+(Itemsstores*) getItemsstoresReadyForItem:(Items*)item
                                   inStore:(Stores*)store
                    inManagedObjectContext:(NSManagedObjectContext*)context
{
    Itemsstores* itemsstore = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Itemsstores"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"item_id=%@ AND store_id=%@", item,store];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *itemsstoreArray = [context executeFetchRequest:request error:&error];
    
    if (!itemsstoreArray || ([itemsstoreArray count] > 1)) {
        // handle error
        NSLog(@"error occur");
    } else if (![itemsstoreArray count]) {
        itemsstore = [NSEntityDescription insertNewObjectForEntityForName:@"Itemsstores"
                                              inManagedObjectContext:context];
        itemsstore.store_id = store;
        itemsstore.item_id =item;
        itemsstore.created= [NSDate date];
        itemsstore.modified = [NSDate date];
        NSLog(@"added new itemsstore =====%@", [itemsstore description]);
    } else {
        itemsstore  = [itemsstoreArray lastObject];
        
        NSLog(@"existed itemsstore:===>\nR%@", [itemsstore description]);
    }
    return itemsstore;
}



@end
