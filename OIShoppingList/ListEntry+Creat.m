//
//  ListEntry+Creat.m
//  OIShoppingList
//
//  Created by Tian Hongyu on 12/5/12.
//  Copyright (c) 2012 OpenIntents. All rights reserved.
//

#import "ListEntry+Creat.h"

@implementation ListEntry (Creat)
+(ListEntry *) creatListEntryWithTittle:(NSString *) tittle
          inManagedObjectContext:(NSManagedObjectContext *)context;
{
    ListEntry  *listEntry = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ListEntry"];
    request.predicate = [NSPredicate predicateWithFormat:@"tittle = %@", tittle];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tittle" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error = nil;
    NSArray *entryList = [context executeFetchRequest:request error:&error];
    
    if (!entryList || ([entryList count] > 1)) {
        // handle error
    } else if (![entryList count]) {
        listEntry = [NSEntityDescription insertNewObjectForEntityForName:@"ListEntry"
                                                     inManagedObjectContext:context];
        listEntry.tittle=tittle;
        listEntry.display = [NSNumber numberWithBool:YES];
        listEntry.marked = [NSNumber numberWithBool:NO];
    } else {
        listEntry   = [entryList lastObject];
    }
    
    return listEntry;

}


@end
